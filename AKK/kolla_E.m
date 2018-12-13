if length(E)>1 | length(E)<1
   set(meddelande,'visible','on');
   %set(pb_start,'enable','off');
end

if length(E)==1
   set(meddelande,'visible','off');
   %set(pb_start,'enable','on');
end
