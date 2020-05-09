with Tas_Int, Ada.Text_Io,ecriture;
use Ada.Text_Io,Tas_int;

procedure Heapsort(File_Name:in String;T :in out Un_tas) is
   type Tab is array (Natural range 1..Cardinal(T) ) of Integer;
   R : integer;
   Tableau : Tab;
begin
   for Number in 1..Cardinal(T) loop
      Enlever_Racine(T,R);
      Tableau(Number) := R;
   end loop;
   Ecriture(T);
end Heapsort;
