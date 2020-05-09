package body Init_Tas_Int is
   
   function Cle_De_Int(I: in integer) return Integer is
   begin
      return I;
   end Cle_De_Int;
   
   function Int_Comp(I1,I2 : in integer) return Boolean is
   begin
      return I1 < I2;
   end int_Comp;
   
   procedure Liberer_Int(I : in out Integer) is
   begin
      null;
   end Liberer_Int;
   
end Init_Tas_Int;
