with Contacts,Ada.Text_Io,Listes_Ordonnees_contacts;
use Contacts,Ada.Text_Io,Listes_Ordonnees_contacts;



procedure Lecture_liste(File_Name : in String; A : out Une_Liste_ordonnee) is
   F : File_Type;
   C : Un_Contact;
   S : String(1..80);
   L : Natural;
begin
   Put_Line("Ouverture du fichier" & File_name & "......");
   Open(F,In_File,FIle_Name);
   
   --boucle de lecture
   while not End_Of_Line(F) loop
      Get_Line(F,S,L);
      String_To_Contact(S(1..L-1),C);
      Inserer(C,A);
   end loop;
   Close(F);
end Lecture_liste;
