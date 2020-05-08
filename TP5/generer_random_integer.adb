-- Avril 2014
-- Auteurs : MJ. Huguet - R. Guillerm
--
-- Mise à jour :
--
------------------------------------------------------------------------
with Ada.Text_IO;                         use Ada.Text_Io;
with Ada.Integer_Text_Io;                 use Ada.Integer_Text_Io;
with Ada.Numerics.Discrete_Random;
with Arbre_Binaire_Recherche_G;

procedure Generer_Random_Integer is
   

   -----------------------------------------------------------------------------
   -- Instanciation Arbre Binaire Générique sur des entiers
   procedure Liberer_Entier(N : in out Integer) is
   begin
      null;
   end Liberer_Entier;
   
   function Cle(N : Integer) return Integer is
   begin
      return N;
   end Cle;
   
   package Arbre_Entiers is new Arbre_Binaire_Recherche_G(Integer, Integer, Cle, "<", "=", Liberer_Entier, Integer'Image);
   use Arbre_Entiers;
   -----------------------------------------------------------------------------
      Binf, Bsup, NVal : Integer;
begin
   Put("borne inf : ");Get(Binf);
   Put("borne sup : ");Get(Bsup);
   Put("nb valeur : ");Get(NVal);
   declare
      subtype Mes_Valeurs is Integer range Binf..Bsup;
      package My_Random_val is new Ada.Numerics.Discrete_Random(Mes_Valeurs) ;
      use My_Random_Val;
      Gen : My_Random_Val.Generator;
      A : Arbre;
      Val : Mes_Valeurs;
      Cpt : Natural := 0;
      F : File_Type;
      Nom : String :="data.txt";
   begin
      Create(F, Out_File, "data.txt");
      Put_Line(F, Integer'Image(NVal));
      loop
	 Val := My_Random_Val.Random(Gen);
	 if not Appartient(Val, A) then
	    Cpt := Cpt + 1;
	    Inserer(Val, A);
	    Put_line(F, Integer'Image(Val));
	 end if;
	 exit when Cpt = NVal;
      end loop;
      Close(F);
      Put_Line(Arbre_To_String(A));
   end;   
end Generer_Random_Integer;
