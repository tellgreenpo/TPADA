with Lecture,Tas_Int,Ada.Text_Io,ecriture;
use Tas_Int, Ada.Text_io;

procedure Test_Lecture is
   T : Un_Tas(110);
begin
   Lecture("data_100.txt",T);
   Put_Line(Tas_To_String(T));
   Ecriture(T);
end Test_Lecture;
