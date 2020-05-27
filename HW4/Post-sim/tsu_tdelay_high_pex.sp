* -------------------------------------------------------------------
*|                     Do Not Revise This Document                  |
* -------------------------------------------------------------------


**********************************************************************
**                          Simulation Setup                        **
**********************************************************************

.prot                                                 
.lib 'cic018.l' tt                            
.unprot                                               
.option post = 1                                        
.option accurate=1                                       
.option runlvl=5  
.option captab
.option measform=3
.option numdgt=5 measdgt=5
.temp 25                    
.ic v(Q)=0
.include "MS_DFF.pex.netlist" $include Master Slave DFF circuit
                
****************************End of Segment****************************



**********************************************************************
**                        Parameter Definition                      **
**********************************************************************

.param VDD = 1.8
.param VSS = 0
.param Cload = 200f
.param freq_in = 50x
.param clk_prd  = '(1/freq_in)'
.param clk_trf  = 0.1n
.param tdelay = 100p

****************************End of Segment****************************



****************************Master Slave DFF**************************
X1 VDD VSS CK CKB CKin D Q / MS_DFF $�̶��ǱƦC
CL Q gnd Cload


**********************************************************************
**                          External Source                         **
**********************************************************************

VDD VDD gnd VDD
VSS VSS gnd VSS
v_clk CKin gnd pulse(0 VDD 0 clk_trf clk_trf 'clk_prd/2-clk_trf' clk_prd)
Vin_D D gnd pwl(0 0 '3*clk_prd-tdelay' 0 '3*clk_prd+clk_trf-tdelay' vdd )
.tran 0.1p 'clk_prd*10' sweep tdelay -150p 300p 1p  $sweep the delay time between D and CKin on your own
***************************************End of Segment**********************************************



**********************************************************************
**                     Simulation & Measurement                     **
**********************************************************************

**************************** transitions******************************
*******rising setup time, rising tD2Q, and rising TCK2Q testing*******
.MEAS tran t_SUr TRIG v(D) VAL = 'VDD / 2' RISE=1
 + TARG v(CKin) VAL = 'VDD / 2' RISE=4
 
.MEAS tran TD2Qr TRIG v(D) VAL = 'VDD / 2' RISE=1
 + TARG v(Q) VAL = 'VDD / 2' RISE=2
 
.MEAS tran tCK2Qr TRIG v(CKin) VAL = 'VDD / 2' RISE=4
 + TARG v(Q) VAL = 'VDD / 2' RISE=2



****************************End of Segment****************************

.end