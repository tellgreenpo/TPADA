with Piles_Entiers
procedure Evaluation_xpression is
    
  type Tab is array (positive range 1..26) of integer ;
  
  type Cellule;
  type Liste   is access Cellule;
  type Cellule is record
     Info : Integer;
     Suiv : Liste;
  end record ;
  
  procedure Evaluation(L : Liste; V : Tab; P : in out Piles_Entiers.Pile) is
     L1 : Liste ;
     I : Integer ;
  begin
     L1 := L ;
     I := 1 ;
     while L1.all.Suiv /= null loop
	I := I+1 ;
	if V(I) = L1.all.Info then
	   Piles_Entiers.Empiler(L1.all.Info,P) ;
	else 
	   null ;
	end if ;	
     end loop ;
  end Evaluation ;
	
     
     
     
  begin
   null;
  end Evaluation_xpression;
