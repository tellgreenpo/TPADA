   -- Ordre lexicographique strict entre 2 String
function Inf_String(S1,S2 : in String) return Boolean is
   Res : Boolean;
begin
   if S1'Length = 0 and then S2'Length = 0 then
        Res := FALSE;
   elsif S1'Length=0 then
      Res := TRUE;
   elsif S2'Length=0 then
      Res := FALSE;
   else
      Res := S1(S1'First) < S2(S2'First) or else
             (S1(S1'First) = S2(S2'First) and then S1(S1'First+1..S1'Last) < S2(S2'First+1..S2'Last));
   end if;
   return Res;
end Inf_String;