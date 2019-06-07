% This script is written and read by pdetool and should NOT be edited.
% There are two recommended alternatives:
% 1) Export the required variables from pdetool and create a MATLAB script
%    to perform operations on these.
% 2) Define the problem completely using a MATLAB script. See
%    http://www.mathworks.com/help/pde/examples/index.html for examples
%    of this approach.
function pdemodel
[pde_fig,ax]=pdeinit;
pdetool('appl_cb',1);
pdetool('snapon','on');
set(ax,'DataAspectRatio',[1 2 80]);
set(ax,'PlotBoxAspectRatio',[1 0.72101194659170775 0.72101194659170775]);
set(ax,'XLim',[0 0.025000000000000001]);
set(ax,'YLim',[0 0.050000000000000003]);
set(ax,'XTick',[ 0,...
 0.0025000000000000001,...
 0.0050000000000000001,...
 0.0074999999999999997,...
 0.01,...
 0.012500000000000001,...
 0.015000000000000001,...
 0.017500000000000002,...
 0.02,...
 0.022500000000000003,...
 0.025000000000000001,...
]);
set(ax,'YTick',[ 0,...
 0.0025000000000000001,...
 0.0050000000000000001,...
 0.0074999999999999997,...
 0.01,...
 0.012500000000000001,...
 0.014999999999999999,...
 0.017500000000000002,...
 0.02,...
 0.022499999999999999,...
 0.025000000000000001,...
 0.027500000000000004,...
 0.030000000000000002,...
 0.032500000000000001,...
 0.035000000000000003,...
 0.037500000000000006,...
 0.040000000000000001,...
 0.042500000000000003,...
 0.045000000000000005,...
 0.047500000000000001,...
 0.050000000000000003,...
]);
pdetool('gridon','on');

% Geometry description:
pderect([0 0.025000000000000001 0.050000000000000003 0.047500000000000001],'R1');
pderect([0 0.0025000000000000001 0.047500000000000001 0.014999999999999999],'R2');
pderect([0 0.0025000000000000001 0.014999999999999999 0],'R3');
pderect([0.0025000000000000001 0.01 0.047500000000000001 0.0025000000000000001],'R4');
pderect([0.0025000000000000001 0.025000000000000001 0.0025000000000000001 0],'R5');
pderect([0.01 0.025000000000000001 0.047500000000000001 0.042500000000000003],'R6');
pderect([0.01 0.015000000000000001 0.042500000000000003 0.014999999999999999],'R7');
pderect([0.022500000000000003 0.025000000000000001 0.032500000000000001 0.0025000000000000001],'R8');
pderect([0.015000000000000001 0.022500000000000003 0.042500000000000003 0.0025000000000000001],'R9');
pdepoly([ 0.01,...
 0.012500000000000001,...
 0.015000000000000001,...
],...
[ 0.014999999999999999,...
 0.012500000000000001,...
 0.014999999999999999,...
],...
 'P1');
pdepoly([ 0.01,...
 0.01,...
 0.012500000000000001,...
],...
[ 0.014999999999999999,...
 0.012500000000000001,...
 0.012500000000000001,...
],...
 'P2');
pdepoly([ 0.012500000000000001,...
 0.015000000000000001,...
 0.015000000000000001,...
],...
[ 0.012500000000000001,...
 0.012500000000000001,...
 0.014999999999999999,...
],...
 'P3');
pderect([0.01 0.015000000000000001 0.012500000000000001 0.0025000000000000001],'R10');
pderect([0.022500000000000003 0.025000000000000001 0.042500000000000003 0.032500000000000001],'R11');
set(findobj(get(pde_fig,'Children'),'Tag','PDEEval'),'String','R1+R2+R3+R4+R5+R6+R7+R8+R9+P1+P2+P3+R10+R11')

% Boundary conditions:
pdetool('changemode',0)
pdetool('removeb',[15 17 27 26 19 20 18 14 7 25 12 ]);
pdesetbd(37,...
'dir',...
1,...
'1',...
'0')
pdesetbd(36,...
'dir',...
1,...
'1',...
'0')
pdesetbd(35,...
'dir',...
1,...
'1',...
'0')
pdesetbd(34,...
'dir',...
1,...
'1',...
'0')
pdesetbd(33,...
'dir',...
1,...
'1',...
'0')
pdesetbd(6,...
'dir',...
1,...
'1',...
'0')
pdesetbd(5,...
'dir',...
1,...
'1',...
'0')
pdesetbd(4,...
'dir',...
1,...
'1',...
'0')
pdesetbd(3,...
'dir',...
1,...
'1',...
'0')
pdesetbd(2,...
'dir',...
1,...
'1',...
'0')
pdesetbd(1,...
'dir',...
1,...
'1',...
'0')

% PDE coefficients:
pdeseteq(1,...
'1.0',...
'0.0',...
'10.0',...
'1.0',...
'0:10',...
'0.0',...
'0.0',...
'[0 100]')
setappdata(pde_fig,'currparam',...
['1.0 ';...
'0.0 ';...
'10.0';...
'1.0 '])

% Solve parameters:
setappdata(pde_fig,'solveparam',...
char('0','1932','10','pdeadworst',...
'0.5','longest','0','1E-4','','fixed','Inf'))

% Plotflags and user data strings:
setappdata(pde_fig,'plotflags',[1 1 1 1 1 1 1 1 0 0 0 1 1 0 0 0 0 1]);
setappdata(pde_fig,'colstring','');
setappdata(pde_fig,'arrowstring','');
setappdata(pde_fig,'deformstring','');
setappdata(pde_fig,'heightstring','');
