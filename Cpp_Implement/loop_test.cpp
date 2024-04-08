// 01800513	//addi a0, zero, 24
// 00300593	//addi a1, zero, 3
// 00000393	//addi t2, zero, 0
// 00058E33	//add t3 a1 zero
// 01C54863	//blt a0, t3, 16
// 00138393	//addi t2, t2, 1
// 00BE0E33	//add , t3, t3, a1
// FF5FF06F	//jal zero, -12
// 00038533	//add a0, t2, zero

#include <iostream>

int main() {
    int a0 = 24;
    int a1 = 3;
    int t2 = 0;
    int t3 = a1; // Initialize t3 to the same value as a1, which is 3

    while (a0 > t3) { // Loop until a0 is less than or equal to t3
        t2++;        // Increment t2
        t3 += a1;    // Increment t3 by the value of a1
    }

    a0 = t2; // At the end, copy the value of t2 to a0

    std::cout << "Final value of a0: " << a0 << std::endl;

    return 0;
}

