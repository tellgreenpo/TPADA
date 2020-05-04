with Ada.Text_Io;

procedure Afficher_Test(Objet_du_Test, Attendu, Obtenu : in  String) is
begin
   Ada.Text_Io.New_Line;
   Ada.Text_Io.Put_Line("-----------------------------------------------------------");
   Ada.Text_Io.Put_Line(Objet_du_Test);
   Ada.Text_Io.Put_Line("Resultat attendu : " & Attendu);
   Ada.Text_Io.Put_Line("Resultat obtenu  : " & Obtenu);
   Ada.Text_Io.New_Line;
end Afficher_Test;
