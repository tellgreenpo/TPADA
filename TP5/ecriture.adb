with Ada.Text_Io, Tas_Int;
use Ada.Text_Io, Tas_Int;

procedure Ecriture(T : in Un_tas) is
   F: File_Type;
begin
   Open(F, Out_File,"resu.txt");
   Put_line(F,Tas_To_String(T));
   Close(F);
end Ecriture;
