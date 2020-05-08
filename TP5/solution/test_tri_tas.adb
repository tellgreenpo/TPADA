-- Avril 2014
-- Auteurs : MJ. Huguet - R. Guillerm
--
-- Mise à jour : avril 2015
-- Auteur : MJ. Huguet
--  modif suite à changements dans le paquetage generique de tas
--  et taille du tas fixee après lecture dans le fichier
------------------------------------------------------------------------
with Ada.Text_IO, Ada.Integer_Text_IO, Tas_Gen;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure Test_Tri_Tas is
   -----------------------------------------------------------------------------
   -- Instanciation Tas sur des entiers
   procedure Liberer_Entier(N : in out Integer) is
   begin
      null;
   end Liberer_Entier;

   function Cle(N : in Integer) return Integer is
   begin
      return N;
   end Cle;

   package Tas_Entiers is new Tas_Gen(Integer, Integer, Cle, "<", Liberer_Entier, Integer'Image);
   use Tas_Entiers;
   -----------------------------------------------------------------------------


   --------------------------------------------
   -- Sous-programmes
   --------------------------------------------

   -- charge les donnees du fichier ouvert dans un Tas
   procedure Charger_Donnees(F : in File_Type; T : in out Un_Tas) is
      N : Integer;
   begin
      while not End_Of_File(F) loop
         Get(F, N);
         Skip_Line(F);
         Ajouter(N, T);
      end loop;
   end Charger_Donnees;

   -- Utilisation du tas pour enregistrer les valeurs dans le tableau, par ordre croissant
   procedure Write_To_File(F : in File_Type; T : in out Un_Tas) is
      Nb_Val : Integer;
      N : Integer;
   begin
      Nb_Val := Cardinal(T);
      for I in 1..Nb_Val loop
         Enlever_Racine(T,N); -- on recupère la plus petite valeur
         Put_Line(F, Integer'Image(N));
      end loop;
   end Write_To_File;


   --------------------------------------------
   -- Programme principal
   --------------------------------------------

   F_In, F_Out : File_Type;
   Taille : Integer;
BEGIN
   Open(F_In, In_File, "data\data_100.txt");
   Get(F_in, Taille);
   Skip_Line(F_In);
   declare
      T : Un_Tas(Taille);
   begin
      -- lecture des valeurs et memorisation dans le tas
      New_Line;
      Put_Line("1. Lecture des valeurs et memorisation dans le Tas.");
      Charger_Donnees(F_In, T);
      Close(F_In);

      -- Affichage du tas
      Put_Line("2. Affichage du Tas (min) : "); New_Line;
      Put_Line(Tas_Entiers.Tas_To_String(T)); New_Line;

      --  -- Ecriture du tas dans un fichier
      Create(F_Out, Out_File, "res_100.txt");
      Put_Line(F_Out, Integer'Image(Cardinal(T)));
      Put_Line(Integer'Image(Cardinal(T)));
      Put_Line("3. Utilisation du Tas pour ecrire les valeurs dans un fichier par ordre croissant.");
      Write_To_File(F_Out,T);
   end;

end Test_Tri_Tas;
