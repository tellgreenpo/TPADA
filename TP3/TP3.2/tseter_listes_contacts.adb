with Ada.Text_Io,Listes_Ordonnees_Contacts,Contacts,Lire_Mot,Ada.Strings.unbounded;
use Listes_Ordonnees_Contacts,Ada.Text_io,Contacts,Lire_mot;

procedure Tseter_Listes_Contacts is
   function Contactz return string is
      F : File_Type;
      Line : String(1..80);
      Last : Natural;
      Dp,Fp,Dn,Fn,Dv,Fv,Ds,Fs,Dt,Ft: integer;
   begin
      Open(F,In_File,"2015-02-16_11-34-06_Annuaire_10.txt");
      while not End_Of_File(F) loop
	 Get_Line(F,Line,Last);
	 Lire_Mots(Line(Line'First..Line'last),dp,fp);
	 Lire_Mots(Line(Fp+1..Line'last),dn,fn);
	 Lire_Mots(Line(Fn+1..Line'last),dv,fv);
	 Lire_Mots(Line(Fv+1..Line'Last),ds,fs);
	 Lire_Mots(Line(Fs+1..Line'last),dt,ft);			 
      end loop ;
      Close(F);
      return  Contact_To_String(Initialiser_Contact(Line(dp..fp),Line(dn..fn),Line(dv..fv),Line(ds..fs),Line(dt..ft)));
   end Contactz ;
begin
   Put_Line(contactz);
end Tseter_Listes_Contacts ;
