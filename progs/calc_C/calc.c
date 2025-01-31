#include <stdio.h>

int main() {
    char operator;
    double num1, num2;

    printf("Enter 2 numbers: ");
    scanf("%lf %lf", &num1, &num2);

    printf("Enter operation (+, -, *, /): ");
    scanf(" %c", &operator);

    switch(operator) {
        case '+':
            printf("%.2lf + %.2lf = %.2lf\n", num1, num2, num1 + num2);
            break;
        case '-':
            printf("%.2lf - %.2lf = %.2lf\n", num1, num2, num1 - num2);
            break;
        case '*':
            printf("%.2lf * %.2lf = %.2lf\n", num1, num2, num1 * num2);
            break;
        case '/':
            if (num2 == 0) {
                printf("Err.\n");
            } else {
                printf("%.2lf / %.2lf = %.2lf\n", num1, num2, num1 / num2);
            }
            break;
        default:
            printf("Некорректная операция.\n");
    }

    return 0;
}