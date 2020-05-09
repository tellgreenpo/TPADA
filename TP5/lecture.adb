with tas_int,Ada.Text_Io;
use Tas_int,Ada.Text_Io;



procedure Lecture(File_Name : in String; A : out Un_tas) is
   F : File_Type;
   I : Integer;
   S : String(1..80);
   L : Natural;
begin
   Put_Line("Ouverture du fichier" & File_name & "......");
   Open(F,In_File,FIle_Name);
   
   --boucle de lecture
   while not End_Of_Line(F) loop
      Get_Line(F,S,L);
      I := Integer'value(S(1..L));
      Ajouter(I,A);
   end loop;
   Close(F);
end Lecture;
