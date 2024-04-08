#include <iostream>
#include <vector>
#include <cstdint>
#include <chrono>
using namespace std::chrono;

// The S-box
int SBox[16] = {0xC, 0x5, 0x6, 0xB, 0x9, 0x0, 0xA, 0xD, 0x3, 0xE, 0xF, 0x8, 0x4, 0x7, 0x1, 0x2};

// The P-layer permutation
const uint8_t PBox[64] = {
    0, 16, 32, 48, 1, 17, 33, 49, 2, 18, 34, 50, 3, 19, 35, 51,
    4, 20, 36, 52, 5, 21, 37, 53, 6, 22, 38, 54, 7, 23, 39, 55,
    8, 24, 40, 56, 9, 25, 41, 57, 10, 26, 42, 58, 11, 27, 43, 59,
    12, 28, 44, 60, 13, 29, 45, 61, 14, 30, 46, 62, 15, 31, 47, 63
};

// Key scheduling for PRESENT-80
std::vector<uint64_t> keySchedule(uint64_t keyUpper, uint16_t keyLower) {
    std::vector<uint64_t> roundKeys(32);

    for (int i = 0; i < 32; ++i) {
        // Take 64 bits for the round key
        roundKeys[i] = keyUpper;

        // XOR round counter before shifted
        uint64_t xorResult = static_cast<uint64_t>(((keyUpper >> 18) & 0x1f) ^ (i+1)) << 18;
        keyUpper = (keyUpper & 0xFFFFFFFFFF83FFFF) | xorResult;

        // Key update
        // Rotate 61 bits to the left
        uint64_t tempUpper = keyUpper;
        uint16_t tempLower = keyLower;
        keyUpper = (tempUpper << 61) | (tempUpper >> 19) | (static_cast<uint64_t>(tempLower) << 45);
        keyLower = static_cast<uint16_t>((tempUpper >> 3) & 0xFFFF);

        // Apply S-box to the leftmost 4 bits of the key
        int topNibble = static_cast<int>((keyUpper >> 60) & 0xF);
        keyUpper = (keyUpper & 0x0FFFFFFFFFFFFFFF) | (static_cast<uint64_t>(SBox[topNibble]) << 60);
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
    uint64_t keyUpper = 0x0;  // Lower 64 bits of the 80-bit key
    uint16_t keyLower = 0x0;  // Upper 16 bits of the 80-bit key
    uint64_t plaintext = 0x20051116; // 64-bit plaintext
    // time_t start, end;

    auto start = high_resolution_clock::now();
    // Generate round keys
    std::vector<uint64_t> roundKeys = keySchedule(keyUpper, keyLower);

    // Encrypt the plaintext
    uint64_t ciphertext = presentEncrypt(plaintext, roundKeys);
    auto stop = high_resolution_clock::now();
    auto duration = duration_cast<microseconds>(stop - start);
    std::cout << duration.count()  << " microseconds"<< std::endl;
    std::cout << "Ciphertext:: " << std::hex << ciphertext<< std::endl;

    return 0;
}
