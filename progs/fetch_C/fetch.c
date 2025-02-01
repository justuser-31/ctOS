#include <stdio.h>
#include <unistd.h>
#include <sys/sysinfo.h>
#include <sys/utsname.h>

void get_system_info() {
    struct utsname unameData;
    struct sysinfo sysInfo;

    // Получаем информацию об ОС
    uname(&unameData);
    printf("\n");
    printf("░█████╗░████████╗░█████╗░░██████╗   System information:\n");
    printf("██╔══██╗╚══██╔══╝██╔══██╗██╔════╝   System: ctOS %s\n", unameData.sysname);
    printf("██║░░╚═╝░░░██║░░░██║░░██║╚█████╗░   Kernel: %s\n", unameData.release);

    // Получаем информацию о системе
    sysinfo(&sysInfo);
    printf("██║░░██╗░░░██║░░░██║░░██║░╚═══██╗   RAM: %lu KB\n", sysInfo.totalram);
    printf("╚█████╔╝░░░██║░░░╚█████╔╝██████╔╝\n");
    printf("░╚════╝░░░░╚═╝░░░░╚════╝░╚═════╝░\n\n");
    printf("        By @justuser_31 (aswer) and @justuser31 (_SAN5_SkeLet0n_)\n");
    printf("\n");

    // ... другие вызовы для получения информации
}

int main() {
    get_system_info();
    return 0;
}