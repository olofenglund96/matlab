% Demo för addition av sinusvågor
%
% Starta skriptet genom att trycka <F5> eller "Run"
% Tryck på en av punkterna i amplitudrutan och rulla
% med mushjulet för att öka amplituden för den frekvensen
% Analogt för fasruta för att ändra fasen för en frekvens
%
% Genom att addera sinusvågor kan man syntetisera vilken
% periodisk funktion som helst. Försök skapa
% 1) en fyrkantsvåg
% 2) en sågtandsvåg
% 3) en svävning (beat på engelska)

function waveAddDemo()
  clear all
  clc
  clf

  global freqs f N U phi x n subplots selectedIdx

  fmax=5;
  freqs=101;
  f=linspace(0,1,freqs)*fmax;
  N=freqs*10;

  U=zeros(size(f));
  phi=zeros(size(f));

  x=linspace(0,10,N);

  n=ones(size(f));

  subplots=zeros(3,1);
  selectedIdx=0;
  drawWaves()

  %---handle initialization
  handles = guidata(gca);
  handles.activeIdx=0;
  guidata(gca,handles);
  handles.init_state = uisuspend(gcf);guidata(gca,handles); %--save initial state

  set(gcf, 'windowbuttondownfcn', {@clickCallback,1});
  set(gcf, 'windowbuttonmotionfcn', {@clickCallback,2});
  set(gcf, 'windowbuttonupfcn', {@clickCallback,3});
  set(gcf, 'windowscrollwheelfcn', {@clickCallback,4});
end

function drawWaves()
  global freqs f N U phi x n subplots selectedIdx

  uu=zeros(freqs,N);
  for k=1:freqs
    uu(k,:)=U(k)*sin(f(k)*2*pi*x+phi(k));
  end
  u=sum(uu,1);

  figure(1)
  subplot(221)
  plot(x,u)
  xlabel('x')
  ylabel('u(x)')
  ylim([-1 1]*max([1 max(abs(u))]))
  grid on
  subplots(1)=gca;
  title('Total signal')
  
  subplot(223)
  uuu=uu(abs(U)>1e-3,:);
  if ~isempty(uuu)
    plot(x,uuu)
  end
  xlabel('x')
  ylim([-1 1]*max([1 max(U)]))
  grid on
  title('Frekvenskomponenter')

  subplot(222)
  plot(f,U,'.-')
  if selectedIdx~=0
    hold on
    plot(f(selectedIdx), U(selectedIdx), 'o')
    hold off
  end
  xlabel('f')
  ylabel('|U(f)|')
  ylim([0 max([1 2*max(U)])])
  grid on
  subplots(2)=gca;
  title('Frekvenskomponenternas amplitud')

  subplot(224)
  plot(f,phi,'.-')
  if selectedIdx~=0
    hold on
    plot(f(selectedIdx), phi(selectedIdx), 'o')
    hold off
  end
  xlabel('f')
  ylabel('arg\{U(f)\}')
  ylim([-1 1]*pi*1.1)
  set(gca, 'YTick', pi*(-1:0.5:1))
  set(gca, 'YTickLabel', {'-pi', '-pi/2', '0', 'pi/2', 'pi'})
  grid on
  subplots(3)=gca;
  title('Frekvenskomponenternas fas')
end

function clickCallback(~,event,type)
  global f U phi n subplots selectedIdx

  handles=guidata(gca);
  out=get(gca,'CurrentPoint');
  switch type
    case 1 % Mouse button down
      %set(gcf,'Pointer','fullcrosshair');
      handles.whichPlot=find(subplots==gca);
      if isempty(handles.whichPlot)
        handles.whichPlot = 0;
      end
      xpos=out(1,1);
      [~,handles.activeIdx]=min(abs(f-xpos));
      selectedIdx=handles.activeIdx;
      handles.mouseYStart=out(1,2);
      handles.relMove = 0;
      switch handles.whichPlot
        case 2 % Spectral amplitude
          handles.pointYStart=U(handles.activeIdx);
        case 3 % Spectral phase
          handles.pointYStart=phi(handles.activeIdx);
        case 4 % Refractive index
          handles.pointYStart= n(handles.activeIdx);
      end
      handles.yPos = handles.pointYStart;
    case 2 % Mouse move
    case 3 % Mouse button up
      %set(gcf,'Pointer','arrow');
      handles.activeIdx=0;
    case 4 % Mouse wheel move
      if selectedIdx~=0
        handles.yPos = handles.yPos - event.VerticalScrollCount*0.1;
        switch handles.whichPlot
          case 2 % Spectral amplitude
            handles.yPos=max([0 handles.yPos]);
            U(selectedIdx)=handles.yPos;
          case 3 % Spectral phase
            handles.yPos=min([abs(handles.yPos) pi])*sign(handles.yPos);
            phi(selectedIdx)=handles.yPos;
          case 4 % Refractive index
            n(selectedIdx)=handles.yPos;
        end
      end
  end
  guidata(gca,handles)
  if type==1 || ((type==2||type==4) && selectedIdx~=0) || type==3
    drawWaves()
  end
end
