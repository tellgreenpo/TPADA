-- inspire par Test_piles entiers de P. Esquirol

with Ada.Text_Io,Listes_Ordonnees_entiers, Afficher_Test;
use  Ada.Text_Io, Listes_Ordonnees_entiers;

procedure Tests_listes_Entiers is
begin

	----------------------
	-- 1. Test d'insertion
	----------------------
   declare
      L : Une_Liste_Ordonnee_entiers;
   begin
      New_Line;
      Put_Line("Test 3 : inserer 10 entiers ");
      for Num in 1..10 loop
	 inserer(Num,P) ;
      end loop ;
      Afficher_Test("Taille suite a inserer(L) ?","10",Natural'Image(L.Taille)) ;
      Afficher_Test("Entiers insere suite a inserer(L)","10 9 8 7 6 5 4 3 2 1",Liste_To_string(L)) ;
   exception when Element_Deja_Present
     =>Put_Line("excetpion levee correctement");
   end;

	--------------------------------
	-- 3. Tests de Depiler et Sommet
	--------------------------------
   declare
      P  : Pile;
      Nb : Integer;
   begin
      -- Empiler 10 elements
      for Num in 1..10 loop
	 Empiler(Num,P) ;
      end loop ;
      New_Line;
      Put_Line("Test 4: Affichage du sommet et depilement pendant 10 fois ...");

      -- Verifier que la pile est bien vide apres 10 appels a Depiler
      for Num in 1..10 loop
	 depiler(P) ;
      end loop ;
      Nb :=  Sommet(P);
      Afficher_Test("Depiler(P) ?","pas d'exception levee",Integer'Image(Sommet(P)));
      exception when Pile_Vide => Put_Line("Exception levee") ;
      New_Line;
      Put_Line("Test 5: Tentative de depilement d'une pile vide ...");
      -- Check pour depiler de P vide--
      declare
	 P : Pile;
      begin
	 Depiler(P);
	 Afficher_Test("Depile(P) ?","pas d'exception levee...","");
      exception
	 when Pile_Vide => Put_Line("Exception levee correctement");
      end;
   end;

	-----------------------------------
	-- 4. Test sur l'egalite de 2 piles
	-----------------------------------
	Put_Line("Test 6 : Initialisation de 2 piles P1 et P2, et comparaison, ajout de 10 elements et comparaison");
   declare
      P1, P2 : Pile;
   begin
      null;
      -- P1 et P2 viennent d'etre declarees, elles sont donc vides
      -- Verifier qu'elles sont identiques (P1=P2)
      New_Line;
      Put_Line("Test 6 : Deux piles vides sont-elles identiques ?");
      Afficher_Test("=(P1,P2) ?","True",Boolean'Image("="(P1,P2))) ;
      New_Line;
      Put_line("On empile desormais 10 entiers 1..10 sur les 2 piles");
      for Num in 1..10 loop
	 Empiler(Num,P1) ;
	 Empiler(Num,P2) ;
      end loop ;
      New_Line;
      Put_Line("Test 7 : Deux piles contenant 1..10 sont-elles identiques ?");
      Afficher_Test("=(P1,P2) ?","True",Boolean'Image("="(P1,P2))) ;
   end;
end Tests_Piles_Entiers;
