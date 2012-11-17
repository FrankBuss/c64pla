
                  251715-01 Emulator for C64C

A project that replaces the 64pin PLA in a C64C (pcb assy #250469) with 
two Altera 44pin PLCC type CPLD's type EPM7032SLC44-10

This project is based on the equations in pla.txt at the funet.fi archive
Credits are due to Marko Mäkelä, Jens Schönfeld, Mark Smith & Andreas Boose
for the original work, with some mods being made for this project.

The design files are to be used with Altera's MAX+plus II Baseline
free software, and a familiarity with that environment is needed.
The software is available at http://www.altera.com
Also needed is a ByteblasterMV programming cable for the ISP port, design specs
also available at Altera's web site, I easily constructed my own.
The graphic design editor of MaxPlus is used to open the relevant .gdf file before
compiling and programming.

The equations are contained in c64pla7.tdf in archive Altera_chip1.zip. The CPLD's
also emulate all the bus multiplexing logic of the original C64 by using Altera's
macrofunctions, allowing the original schematic to be reconstructed within the
graphic editor environment of MaxPlus. With reference to schematic #326106
Sheet 2, this includes U17, U26, U14, U15, U27, U13(part), U8(part) and U25. 
This logic is spread over the two CPLD's. 

Files included are;
Altera_chip1.zip.......all design files needed to program chip1
Altera_chip2.zip.......all design files needed to program chip2
251715_pcb.zip.........pcb layouts in .bmp form and true size in .doc
schematic.zip..........Eagle schematic in .sch and .bmp form
readme.txt.............this file

The pcb layouts were originally done with Cadsoft's Eagle (freeware) software, each
layer exported as .bmp's and enhanced in MS Paint due to my rather primitive method of
pcb construction - the toner transfer method - with the need to have the top layer
as a mirror image of the Eagle file plus other enhancements.

There are two boards, the transition board being the lower carrying the 64pins
that connect to the C64C mainboard, the ISP port and 4 resistors.
The top chip carrier board has the two surface mount PLCC sockets on it.
The two boards are spaced apart by 4 scraps of pcb material and connected by an array
of wire links around the perimeter. 
 
The main difficulties with construction center around the 0.070" pitch of the PLA pins.
Sockets are hard to find and expensive, I removed the pinned sockets from standard
turned pin sockets (0.100" pitch), filed the barrels down with a mini-drill as a lathe
and soldered them to the C64C mainboard in 2 rows. This worked very well.

The pins on the transition board that fit into the PLA socket were removed from 50 way
IDC / PCB transition type connectors and modified a little.

The only modification to the C64C mainboard is to add a 150pF capacitor from the
DRAM side of R101 to Ground on the _casram line.

Please note that this project was undertaken as a learning exercise and there
may well be design errors I am unaware of. The prototype works fine in my
previously dead C64C with a variety of software, AR6 & GEOS included.

Graeme Duffy  (graemeduffy@xtra.co.nz)
2nd March 2003
