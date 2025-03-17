import os

name = ""
lang = ""

print("""\n       Creation project and space for program tool\n
Supported programming languages:
    C
    Python
""")
name = input("Enter prog name: ")
lang = input("Enter programming language: ")

folder_name = name + "_" + lang

if (lang == "Python" or lang == "python"):
    print("Main language: Python.")
    print("Creating..")
    os.system(f"mkdir {folder_name}")
    file_name = name + ".py"
    os.system(f"touch {folder_name}/build.sh {folder_name}/{file_name}")
    os.system(f"chmod 777 {folder_name}/build.sh")
    os.system(f"echo 'python3 -m nuitka {file_name} -o {name}; cp {name} ../binary_files;' > {folder_name}/build.sh")
elif (lang == "C" or lang == "c"):
    print("Main language: C.")
    print("Creating..")
    os.system(f"mkdir {folder_name}")
    file_name = name + ".c"
    os.system(f"touch {folder_name}/build.sh {folder_name}/{file_name}")
    os.system(f"chmod 777 {folder_name}/build.sh")
    os.system(f"echo 'musl-gcc --static {file_name} -o {name}; cp {name} ../binary_files;' > {folder_name}/build.sh")
else:
    print("Language not recognized.")
