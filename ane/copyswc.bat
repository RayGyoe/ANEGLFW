rd /s /q swc
del ANEGLFW.swc

copy /y %pathtome%..\swc\lib\ANEGLFW.swc .

unzip.exe ANEGLFW.swc -d swc

copy /y swc\library.swf .
copy /y library.swf default
copy /y library.swf Windows-x86
copy /y library.swf Windows-x86-64

rd /s /q swc