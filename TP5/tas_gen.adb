package body Tas_Gen is
   
   --------------------------------------------------------------------------
   --------------------------------------------------------------------------
   
   procedure Liberer(T : in out Un_Tas) is
   begin
      for Elem reverse in T.Les_Elements'First..T.Les_Elements'Last loop
	 Liberer_Element(elem);
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
   
   procedure Permut_comp(Tab : in out Tab_elements) is
      Aux : Element;
   begin
      --dissociation cas entre deux fils non nuls et un fils_gauche/fils_droite nul
      if Tab(Tab'First*2) = null and Tab(Tab'First*2+1) = null then null;
      elsif Tab(Tab'First*2) = null or Tab(Tab'First*2+1) = null then
	 if Tab(Tab'First*2) = null and Tab(Tab'First*2+1) < Tab(Tab'First) then
	    Aux := Tab(Tab'First);
	    Tab(Tab'First) := Tab(Tab'First*2+1);
	    Tab(Tab'First*2+1) := Aux;
	 elsif Tab(Tab'First*2) < Tab(Tab'First) then
	    Aux := Tab(Tab'First);
	    Tab(Tab'First) := Tab(Tab'First*2);
	    Tab(Tab'First*2) := Aux;
	 end if;
      else
	 --deux fils non nuls
	 --prendre le plus petit des fils et verifier la relation d'ordre
	 if Tab(Tab'First*2+1) <= Tab(Tab'First*2) then
	    if Tab(Tab'First) > Tab(Tab'First*2+1) then
	       --permutation
	       Aux := Tab(Tab'First);
	       Tab(Tab'First) := Tab(Tab'First*2+1);
	       Tab(Tab'First*2+1) := Aux;
	       --recursif si permutation faite pour s'assurer que tout est en ordre
	       Permut_Comp(Tab(Tab'First*2+1));
	    end if;
	 else
	    if Tab(Tab'First) > Tab(Tab'First*2) then
	       --permutation
	       Aux := Tab(Tab'First);
	       Tab(Tab'First) := Tab(Tab'First*2);
	       Tab(Tab'First*2) := Aux;
	       --recursif si permutation faite pour s'assurer que tout est en ordre
	       Permut_Comp(Tab(Tab'First*2));
	    end if;
	 end if;
      end if;
   end Permut_Comp;
   
   ---------------------------------------------------------------------------
   ---------------------------------------------------------------------------
      
   procedure Enlever_Racine(T : in out Un_Tas;E : out Element) is
      Permut_Aux : Element;
   begin
      if T.Cardinal = 0 then raise Tas_Vide;
      else
	 E := T.Les_Elements(1);
	 T.Les_Elements(1) := T.Les_Elements(T.Les_Elements'Last);
	 T.Cardinal := T.Cardinal -1;
	 Permut_Comp(T.Les_elements);
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
	 if Tab(Card) < Tab(Card/2) then
	    Aux := Tab(Card);
	    Tab(Card) := Tab(Card/2);
	    Tab(Card/2) := Aux;
	    --appel recursif pour verifier l'etage superieur
	    Move_Up(Card/2,Tab);
	 end if;
      else
	 if Tab(Card) < Tab((Card-1)/2) then
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
   
   procedure Ajouter(T:in out Un_Tas;E:in element) is
   begin
      if T.Cardinal = T.Les_Elements'Last then raise Tas_Plein;
      else
	 T.Cardinal := T.Cardinal +1;
	 T.Les_Elements(T.Cardinal) := E;
	 --verification de l'ordre de comparaison
	 Move-Up(T.Cardinal,T);
      end if;
   end Ajouter;
   
   ---------------------------------------------------------------------------
   ---------------------------------------------------------------------------
   
   function Tas_To_String(T : in Un_Tas) return String is
      Str : String := "";
   begin
      for Elem in T.Les_Elements'Range loop
	 Str = Str + Element_To_String(elem);
      end loop;
   end Tas_To_String;
   
