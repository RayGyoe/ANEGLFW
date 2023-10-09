del Windows-x86\ANEGLFW.dll
del Windows-x86-64\ANEGLFW.dll

copy /y %pathtome%..\native\ANEGLFW\x64\Release\ANEGLFW.dll "./Windows-x86-64"
copy /y %pathtome%..\native\ANEGLFW\Release\ANEGLFW.dll "./Windows-x86"