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
   
   -------------------------------------------------------------------
   -------------------------------------------------------------------
   
   T : Un_Tas(10);
   Int : Integer;
begin
   Put_line("Test liberer....");
   Liberer(T);
   Put_line(Tas_To_String(T));
   Put_Line("Test cardinal...");
   Put_Line(Natural'Image(Cardinal(T)));
   Put_Line("test ajouter...");
   Ajouter(1,t);
   Ajouter(4,T);
   Ajouter(5,T);
   Ajouter(15,t);
   Ajouter(89,T);
   Ajouter(72,T);
   Ajouter(20,T);
   Ajouter(20,T);
   Put_Line(Tas_To_String(T));
   Enlever_Racine(T,int);
   Put_Line(Tas_To_String(T));
   Enlever_Racine(T,Int);
   Put_Line(Tas_To_String(T));
   Enlever_Racine(T,Int);
   Put_Line(Tas_To_String(T));
end Tester_Tas_Gen;
