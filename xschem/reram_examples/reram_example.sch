v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
B 2 510 -400 830 -190 {flags=graph
y1=-400.0e-6
y2=600.0e-6
ypos1=-400.0e-6
ypos2=600.0e-6
divy=10
subdivy=1
unity=u
x1=-1.5
x2=1.5
divx=5
subdivx=1
node="i(r0)"
color=""
dataset=-1
unitx=1
}
N 190 -310 190 -280 {
lab=TE}
N 190 -310 410 -310 {
lab=TE}
N 410 -310 410 -280 {
lab=TE}
N 190 -220 190 -190 {
lab=0}
N 190 -200 410 -200 {
lab=0}
N 410 -220 410 -200 {
lab=0}
C {devices/vsource.sym} 190 -250 0 0 {name=V1 value="PWL (0 0 
+ 0.25u 1.4
+ 0.5u 0
+ 0.75u -1.4
+ 1.0u 0.0)"}
C {devices/code_shown.sym} 190 -90 0 0 {name=SIMULATE
only_toplevel=false 
value="
.tran 0.1n 1.5u
.print tran format=raw file=reram_example.raw v(*) i(*)
"}
C {devices/gnd.sym} 190 -190 0 0 {name=l2 lab=0}
C {devices/lab_wire.sym} 300 -310 0 0 {name=l1 sig_type=std_logic lab=TE}
C {sky130_fd_pr/reram_cell.sym} 410 -250 0 0 {name=R0
model=reram_cell
Tfilament_0=3.3e-9
spiceprefix=X
}
C {devices/launcher.sym} 520 -420 0 0 {name=h1
descr="Load I-V" 
tclcommand="
set rawfile [file tail [file rootname [xschem get schname]]]
set mk $
set altercmd \\"load $netlist_dir/$\{rawfile\}.raw
set mk=!
let i(r0)=i(xr0:ysky130_fd_pr_reram__reram_module$\{mk\}mk\{r0\})
unlet i(xr0:ysky130_fd_pr_reram__reram_module$\{mk\}mk\{r0\})
unset mk
setscale v(te)
write $netlist_dir/$\{rawfile\}_i-v.raw
quit
\\"
unset mk
exec ngspice -p << $altercmd
unset altercmd
xschem raw_read $netlist_dir/$\{rawfile\}_i-v.raw
unset rawfile
"}
C {devices/code.sym} 180 -480 0 0 {name=MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.inc $::SKYWATER_MODELS/../xyce/sky130_fd_pr_reram__reram_cell.spice

"
spice_ignore=false}
