-- Avril 2014
-- Auteurs : MJ. Huguet - R. Guillerm
--
-- Mise à jour :
--
------------------------------------------------------------------------
with Ada.Text_IO;          use Ada.Text_IO;
with Tas_Gen;

procedure Tester_Tas is
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

   T : Un_Tas(100);
   Val : Integer;
begin
   for I in reverse 1..50 loop
      Ajouter(I, T);
      Put_Line(Tas_To_String(T));
   end loop;
   Put_Line(Tas_To_String(T));

   for I in 1..10 loop
      Enlever_Racine(T, Val);
      New_Line;
      Put_Line("racine : " & Integer'Image(Val));
   end loop;
   New_Line;
   Put_line("Cardinal : " & Integer'Image(Cardinal(T)));
   Put_Line(Tas_To_String(T));
end Tester_Tas;
