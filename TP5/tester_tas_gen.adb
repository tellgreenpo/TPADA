with Tas_Gen,Ada.Text_Io;
use Ada.Text_Io;

procedure Tester_Tas_Gen is
   
   function Cle(I:in Integer) return Integer is
   begin
      return I;
   end Cle;
   
   function Comp(I1,I2:in Integer) return Boolean is
   begin
      return I1<I2;
   end Comp;
   
   procedure Lib(I:in out Integer) is
   begin
      null;
   end Lib;
   

   package Tas_Int is new Tas_Gen(Element=>Integer,
				  Key=>Integer,
				  Cle_De=> Cle,
				  "<"=>Comp,
				  Liberer_Element=>Lib,
				  Element_To_String=>Integer'Image);
   use Tas_Int;
   
begin
   null;
end Tester_Tas_Gen;
