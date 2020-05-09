with Ada.Text_Io, Init_Tas_Int, Tas_gen;
use Ada.Text_Io, Init_Tas_Int;

package Tas_Int is new Tas_Gen(Element=>Integer,
			       Key=> Integer,
			       Cle_De=>Cle_De_Int,
			       "<"=>Int_Comp,
			       Liberer_Element=>Liberer_Int,
			       Element_To_String=>Integer'Image);
			       
			       
