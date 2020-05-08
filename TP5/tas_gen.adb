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
   
   procedure Move_Down(Card : in Natural; T : in out Tab_elements) is
      Aux : Element;   
   begin
      if Card = T'Last then null;
      elsif Card*2 = T'Last then
	 if Cle_De(T(Card)) < Cle_De(T(Card*2)) then 
	    Aux := T(Card);
	    T(Card) := T(Card*2);
	    T(Card*2) := Aux;
	    Move_Down(Card*2,T);
	 end if;
      else
	 if Cle_De(T(Card*2+1))<Cle_De(T(Card*2)) then
	    if Cle_De(T(Card))<Cle_De(T(Card*2+1)) then
	       Aux := T(Card);
	       T(Card) := T(Card*2+1);
	       T(Card*2+1) := Aux;
	       Move_Down(Card*2+1,T);
	    end if;
	 elsif Cle_De(T(Card*2))<Cle_De(T(Card)) then
	    Aux := T(Card);
	    T(Card) := T(Card*2);
	    T(Card*2) := Aux;
	    Move_Down(Card*2,T);
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
	 T.Les_Elements(1) := T.Les_Elements(T.Les_Elements'Last);
	 T.Cardinal := T.Cardinal -1;
	 Move_down(1,T.Les_elements);
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
   
   function Tas_To_String(T : in Un_Tas) return String is
      Str : String := "";
   begin
      for Elem in T.Les_Elements'Range loop
	 Str := Str&Element_To_String(T.Les_Elements(Elem));
      end loop;
      return Str;
   end Tas_To_String;
   
   end Tas_Gen;
