with Ada.Text_Io, Abrs_G;
use  Ada.Text_Io;

procedure Test_Abrs_Entiers is

   -- Definitions des valeurs des sous-programmes Cle_De, Liberer et Copy dans la cas particulier des INTEGER

   -- Ces definitions sont elementaires car le type Integer n'est pas une structure
   -- de donnees complexe possedant plusieurs champs et contenant des pointeurs ...


   function Cle_Integer(E : in Integer) return Integer is
   begin
      return  E;       -- <<< A MODIFIER
   end Cle_Integer;

   procedure Liberer_Integer(E  : in out Integer) is
   begin
      null;               -- Integer n'est pas une structure contenant des pointeurs
   end Liberer_Integer;

   procedure Copie_Integer(E1 : in Integer; E2  : out Integer) is
   begin
      E2 := E1;
   end Copie_Integer;
   
   function equal(A,B : integer) return Boolean is
   begin
      return A=B;
   end equal;
   
   Function smaller(A,B : Integer) return Boolean is
   begin
      return A < B;
   end smaller;
   


   -- **************************
   -- INSTANCIATION DU PAQUETAGE
   -- **************************

   package Abrs_Entiers is new Abrs_G(

      Element           =>  integer,
      Cle               =>  integer,
      Cle_De            =>  Cle_Integer,
      "="               =>  equal,        
      "<"               =>  smaller,
      Liberer_Element   =>  Liberer_integer,
      Element_To_String =>  Integer'image,
      Copy              =>  Copie_integer
                                     );

   use Abrs_Entiers;

A : Abr;

begin
   Put_Line("Initialisation");
   Put_Line("--------------");
   Init_Abr(A);
   
   Inserer(20,A);
   Inserer(10,A);
   Put_line(Boolean'Image(Est_Vide(A)));
   Put_line(Natural'Image(Taille(A)));
   Put_Line(Abr_To_String(A));
   Init_Abr(A);

   Put_Line("Insertion de 20,10,30,5,1,6,15,12,25,22,40,33,50");
   Put_Line("---------------------------------------------");
   Inserer(20,A);
   Put_Line(Abr_To_String(A));
   Inserer(10,A);
   Inserer(30,A);
   Inserer( 5,A);
   Inserer( 1,A);
   Inserer( 6,A);
   Inserer(15,A);
   Inserer(12,A);
   Inserer(25,A);
   Inserer(22,A);
   Inserer(40,A);
   Inserer(33,A);
   Inserer(50,A);

   Put90(A);
   Put_Line(Abr_To_String(A));

   Put_Line("Suppression du noeud contenant 20");
   Put_Line("---------------------------------");

   Supprimer(20,A);

   Put90(A);
   Put_Line(Abr_To_String(A));

   Put_Line("Suppression du noeud contenant 30");
   Put_Line("---------------------------------");

   Supprimer(30,A);

   Put90(A);
   Put_Line(Abr_To_String(A));

   Put_Line("ciao");

end Test_Abrs_Entiers;


