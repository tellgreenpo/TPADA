 procedure Lire_Mot(S : String; Deb, Fin : out Integer) is
      -- cherche le debut et la fin du premier token
      -- si aucun token n'est trouve on aura en sortie : Deb > Fin
   begin
      Deb := S'First;
      Fin := Deb-1;
      while Deb <= S'last and then S(Deb) = ' ' loop
         Deb := Deb+1;    --recherche du debut du 1er mot
      end loop;
      if Deb <= S'Last then
         Fin := Deb;
         while Fin <= S'Last and then S(Fin) /= ' ' loop
            Fin := Fin +1;   --recherche de la fin du 1er mot
         end loop;
         Fin  := Fin-1;
      end if;
   end Lire_Mot;
