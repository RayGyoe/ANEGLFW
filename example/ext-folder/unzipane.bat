rd /s /q ANEGLFW.ane




copy /y %pathtome%..\..\ane\ANEGLFW.ane .

copy /y ANEGLFW.ane %pathtome%..\lib\


unzip.exe ANEGLFW.ane -d ANEGLFW
del ANEGLFW.ane

rename ANEGLFW ANEGLFW.ane

exit