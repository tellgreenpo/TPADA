-- inspire par Test_piles entiers de P. Esquirol

with Ada.Text_Io,Listes_Ordonnees_G,Afficher_test;
use  Ada.Text_Io;

procedure Tests_Listes_Ordonnees_Entiers is
   
   procedure Liberer_Entier(I : in out Integer) is
   begin
      null;
   end Liberer_Entier ;
   
   
   -- instanciation
   package Liste_Ordonnees_Entiers is new Listes_Ordonnees_G(
							    Element => Integer,
							    "<" => "<",
							    "=" => "=",
							    Element_To_String => Integer'Image,
							    Liberer_Element => Liberer_entier);
   
   use Liste_Ordonnees_Entiers;
   
   L1, L2 : Une_Liste_Ordonnee;
begin
   Put_Line("-----------------------------------------------------------");
   Put_Line("Etape 1 : Insertion d'elements dans L1");
   Inserer(3, L1);
   Inserer(5, L1);
   Inserer(4, L1);
   Inserer(2, L1);
   Put_Line("Contenu de L1 : " & Liste_To_String(L1));

   Put_Line("-----------------------------------------------------------");
   Put_Line("Etape 2 - Copie de L1 dans L2");

   Copie(L1,L2);
   Put_Line("Contenu de L2 : " & Liste_To_String(L2));

   Put_Line("-----------------------------------------------------------");
   Put_Line("Etape 3 - Ajout de 1 a L1 et de 1 a L2");
   Inserer(1, L1);
   Inserer(1, L2);
   Put_Line("Contenu de L1 : " & Liste_To_String(L1));
   Put_Line("Contenu de L2 : " & Liste_To_String(L2));

   -- Les deux listes sont-elle egales ?
   Afficher_Test("L1 = L2 ?", "TRUE", Boolean'Image(L1=L2));

   Put_Line("-----------------------------------------------------------");
   Put_Line("Etape 4 - Ajouts de 2 elements 0 et 6 a L1");
   Inserer(0, L1);
   Inserer(6, L1);
   Put_Line("Contenu de L1 : " & Liste_To_String(L1));
   Put_Line("Contenu de L2 : " & Liste_To_String(L2));

  -- Les deux listes sont-elle egales ?
   Afficher_Test("L1 = L2 ?", "FALSE", Boolean'Image(L1=L2));

   Put_Line("-----------------------------------------------------------");
   Put_Line("Etape 5 - Appartenance d'elements");
   Afficher_Test("3 appartient-il a L1 ?", "TRUE",  Boolean'Image(appartient(3,L1)));
   Afficher_Test("6 appartient-il a L2 ?", "FALSE", Boolean'Image(appartient(6,L2)));


end Tests_Listes_Ordonnees_Entiers;
