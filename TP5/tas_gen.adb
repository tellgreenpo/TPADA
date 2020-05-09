with Ada.Text_Io;
use Ada.Text_Io;

package body Tas_Gen is
   
   --------------------------------------------------------------------------
   --------------------------------------------------------------------------
   
   procedure Liberer(T : in out Un_Tas) is
   begin
      for Index  in T.Les_Elements'First..T.Les_Elements'Last loop
	 Liberer_Element(T.Les_Elements(index));
      end loop;
      T.Cardinal := 0;
   end Liberer;
   
   ---------------------------------------------------------------------------
   ---------------------------------------------------------------------------
   
   function Cardinal(T : in Un_Tas) return Natural is
   begin
      return T.Cardinal;
   end Cardinal;
   
   ---------------------------------------------------------------------------
   ---------------------------------------------------------------------------
   
   procedure Permutation(Pos1,Pos2 : in Natural; T : in out Un_Tas) is
      Aux : Element;
   begin
      Aux := T.Les_Elements(Pos1);
      T.Les_Elements(Pos1) := T.Les_Elements(Pos2);
      T.Les_Elements(Pos2) := Aux;
   end Permutation; 
   
   ---------------------------------------------------------------------------
   ---------------------------------------------------------------------------
   
   procedure Move_Down(pos : in Natural; T : in out Un_tas) is  
   begin
      if Pos = T.Cardinal and T.cardinal < Pos*2 then null;
      	 --check quand cardinal est pair et donc un seul fils
      elsif Pos*2= T.Cardinal then
	 --verification relation d'ordre
	 if Cle_De(T.Les_Elements(Pos))<Cle_De(T.Les_Elements(T.Cardinal)) then
	    Permutation(Pos,T.Cardinal,T);
	 end if;
	 --check quel fils est le plus petit
      else
	 if Cle_De(T.Les_Elements(Pos*2))<Cle_De(T.Les_Elements((Pos*2)+1)) then
	 --si c'est celui de gauche on regarde la relation d'ordre avec le pere
	    if Cle_De(T.Les_Elements(Pos*2)) < Cle_De(T.Les_Elements(Pos)) then
	       Permutation(Pos*2,Pos,T);
	       --on continue avec a l'etage inferieur
	       Move_Down(Pos*2,T);
	    end if;
	    --on evite une operation si ils sont egaux
	 elsif Cle_De(T.Les_Elements((Pos*2)+1))<Cle_De(T.Les_Elements(Pos*2)) then
	    --si le fils de droite est plus petit que le pere on permute
	    if Cle_De(T.Les_Elements((Pos*2)+1))<Cle_De(T.Les_Elements(Pos)) then
	       Permutation((Pos*2)+1,Pos,T);
	       --on continue a l'etage inferieur
	       Move_Down((Pos*2)+1,T);
	    end if;
	 end if;
      end if;
   end Move_Down;
	 
   ---------------------------------------------------------------------------
   ---------------------------------------------------------------------------
      
   procedure Enlever_Racine(T : in out Un_Tas;E : out Element) is
   begin
      if T.Cardinal = 0 then raise Tas_Vide;
      else
	 E := T.Les_Elements(1);
	 T.Les_Elements(1) := T.Les_Elements(T.cardinal);
	 T.Cardinal := T.Cardinal -1;
	 Move_down(1,T);
      end if;
   end Enlever_Racine;
   
   ---------------------------------------------------------------------------
   ---------------------------------------------------------------------------
   
   procedure Move_Up(Card : in Natural;Tab : in out Tab_Elements) is
      Aux : Element;
   begin
      --si on ajoute a la racine rien ne se passe
      if Card = 1 then null;
      --simplifier ces deux blocks en 1 avec int() ?
      elsif Card mod 2 = 0 then
	 if Cle_De(Tab(Card)) < Cle_De(Tab(Card/2)) then
	    Aux := Tab(Card);
	    Tab(Card) := Tab(Card/2);
	    Tab(Card/2) := Aux;
	    --appel recursif pour verifier l'etage superieur
	    Move_Up(Card/2,Tab);
	 end if;
      else
	 if Cle_De(Tab(Card)) < Cle_De(Tab((Card-1)/2)) then
	    Aux := Tab(Card);
	    Tab(Card) := Tab((Card-1)/2);
	    Tab((Card-1)/2) := Aux;
	    --appel recursif pour verifier l'etage superieur
	    Move_Up((Card-1)/2,Tab);
	 end if;
      end if;
   end Move_Up;
   
   
   ---------------------------------------------------------------------------
   ---------------------------------------------------------------------------
   
   procedure Ajouter(E:in Element;T: in out Un_tas) is
   begin
      if T.Cardinal = T.Les_Elements'Last then raise Tas_Plein;
      else
	 T.Cardinal := T.Cardinal +1;
	 T.Les_Elements(T.Cardinal) := E;
	 --verification de l'ordre de comparaison
	 Move_Up(T.Cardinal,T.Les_elements);
      end if;
   end Ajouter;
   
   ---------------------------------------------------------------------------
   ---------------------------------------------------------------------------
   
   function Tas_To_String_elements(T : in Tab_Elements;N:in natural) return String is
   begin
      if T'First = n then return Element_To_String(t(T'first));
      else
	 return Element_To_String(T(T'First))&" "&Tas_To_String_elements(T(T'First+1..T'last),N);
      end if;
   End Tas_To_String_elements;

   function Tas_To_String(T : in  Un_Tas) return String is
   begin
      if T.Cardinal = 0 then return "";
      else
	 return Tas_To_String_Elements(T.Les_elements,T.cardinal);
      end if;
   end Tas_To_String;
   
   
end Tas_Gen;
