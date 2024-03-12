#include <iostream>
#include <vector>
#include <cstdint>

// The S-box
const uint8_t SBox[16] = {0xC, 0x5, 0x6, 0xB, 0x9, 0x0, 0xA, 0xD, 0x3, 0xE, 0xF, 0x8, 0x4, 0x7, 0x1, 0x2};

// The P-layer permutation
const uint8_t PBox[64] = {
    0, 16, 32, 48, 1, 17, 33, 49, 2, 18, 34, 50, 3, 19, 35, 51,
    4, 20, 36, 52, 5, 21, 37, 53, 6, 22, 38, 54, 7, 23, 39, 55,
    8, 24, 40, 56, 9, 25, 41, 57, 10, 26, 42, 58, 11, 27, 43, 59,
    12, 28, 44, 60, 13, 29, 45, 61, 14, 30, 46, 62, 15, 31, 47, 63
};

// Key scheduling for PRESENT-80
std::vector<uint64_t> keySchedule(uint64_t keyLower, uint16_t keyUpper) {
    std::vector<uint64_t> roundKeys(32);

    for (int i = 0; i < 32; ++i) {
        // Take 64 bits for the round key
        roundKeys[i] = keyLower;
        std::cout << ": " << std::hex << keyLower << std::endl;



        

        // Key update
        // Rotate 61 bits to the left
        uint64_t tempLower = keyLower;
        uint16_t tempUpper = keyUpper;
        keyLower = (tempLower << 61) | (static_cast<uint64_t>(tempUpper) << 45) | (tempLower >> 19);
        keyUpper = (tempLower >> 3) & 0xFFFF;

        // Apply S-box to the leftmost 4 bits of the key
        uint8_t topNibble = (keyUpper >> 12) & 0xF;
        keyUpper = (keyUpper & 0x0FFF) | (static_cast<uint16_t>(SBox[topNibble]) << 12);

        // XOR round counter, ensure only the lower 5 bits of i are used
        keyLower ^= static_cast<uint64_t>(i & 0x1F) << 59;
    }

    return roundKeys;
}

// The PRESENT encryption algorithm
uint64_t presentEncrypt(uint64_t plaintext, const std::vector<uint64_t>& roundKeys) {
    uint64_t state = plaintext;

    for (int round = 0; round < 31; ++round) {
        // Add round key
        state ^= roundKeys[round];

        // S-box layer
        for (int i = 0; i < 16; ++i) {
            uint8_t nibble = (state >> (4 * i)) & 0xF;
            state = (state & (~(0xFULL << (4 * i)))) | (static_cast<uint64_t>(SBox[nibble]) << (4 * i));
        }

        // P-layer
        uint64_t newState = 0;
        for (int i = 0; i < 64; ++i) {
            newState |= ((state >> i) & 0x1) << PBox[i];
        }
        state = newState;
    }

    // Last round (add round key only)
    state ^= roundKeys[31];

    return state;
}

int main() {
    uint64_t keyLower = 0xFFFFFFFFFFFFFFFF; // Lower 64 bits of the 80-bit key
    uint16_t keyUpper = 0xFFFF;             // Upper 16 bits of the 80-bit key
    uint64_t plaintext = 0x0000000000000000; // 64-bit plaintext

    // Generate round keys
    std::vector<uint64_t> roundKeys = keySchedule(keyLower, keyUpper);

    // Encrypt the plaintext
    uint64_t ciphertext = presentEncrypt(plaintext, roundKeys);

    std::cout << "Ciphertext: " << std::hex << ciphertext << std::endl;

    return 0;
}
