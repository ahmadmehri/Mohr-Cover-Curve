function varargout = MohrCoverCurve(varargin)
% MOHRCOVERCURVE MATLAB code for MohrCoverCurve.fig
%      MOHRCOVERCURVE, by itself, creates a new MOHRCOVERCURVE or raises the existing
%      singleton*.
%
%      H = MOHRCOVERCURVE returns the handle to a new MOHRCOVERCURVE or the handle to
%      the existing singleton*.
%
%      MOHRCOVERCURVE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOHRCOVERCURVE.M with the given input arguments.
%
%      MOHRCOVERCURVE('Property','Value',...) creates a new MOHRCOVERCURVE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MohrCoverCurve_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MohrCoverCurve_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MohrCoverCurve

% Last Modified by GUIDE v2.5 06-Mar-2020 00:23:49

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MohrCoverCurve_OpeningFcn, ...
    'gui_OutputFcn',  @MohrCoverCurve_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before MohrCoverCurve is made visible.
function MohrCoverCurve_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MohrCoverCurve (see VARARGIN)

%Setting figure title
set(hObject,'Name','Non-Linear Mohr circle"s Cover Curve');

%Set Logo
axes(handles.Logo)
matlabImage = imread('UMA.PNG');
image(matlabImage)
axis off
axis image


%My Data
handles.StrSt=[];
handles.MaxSt=[];
handles.MinSt=[];
handles.data=[];
handles.Nrows=20;
handles.Ncolumns=2;
handles.x1=[];
handles.y1=[];
handles.x2=[];
handles.y2=[];
handles.C=[];
handles.R=[];
set(handles.uitable,'Data',cell(handles.Nrows,handles.Ncolumns));
set(handles.FormFigReg,'visible', 'off');
set(handles.FormFig,'visible', 'off');
% Choose default command line output for MohrCoverCurve
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MohrCoverCurve wait for user response (see UIRESUME)
% uiwait(handles.GUi);


% --- Outputs from this function are returned to the command line.
function varargout = MohrCoverCurve_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function Load_Callback(hObject, eventdata, handles)
% hObject    handle to Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.GUi)


% --------------------------------------------------------------------
function CcPlot_Callback(hObject, eventdata, handles)
% hObject    handle to CcPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[F P]=uiputfile({'*.fig','Figures (*.fig)'},'Save Plot as Figure');
NewFig=figure;
NewAx=copyobj(handles.Fig,NewFig);
set(NewAx,'Units','normalized','Position', [0.12 0.12 0.85 0.75]);
hgsave(NewFig,[P F]);
close(NewFig);

% --------------------------------------------------------------------
function RegPlot_Callback(hObject, eventdata, handles)
% hObject    handle to RegPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[F P]=uiputfile({'*.fig','Figures (*.fig)'},'Save Plot as Figure');
NewFig=figure;
NewAx=copyobj(handles.FigReg,NewFig);
set(NewAx,'Units','normalized','Position', [0.12 0.12 0.85 0.75]);
hgsave(NewFig,[P F]);
close(NewFig);

% --- Executes on button press in LoadD.
function LoadD_Callback(hObject, eventdata, handles)
% hObject    handle to LoadD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.SaveDone,'visible','off');
[F P]=uigetfile({'*.txt','n*2 Data Matrix in Text';'*.m','Data in mFile';...
    '*.mat','Matlab File'},'Load n*2 data matrix');
if F
handles.StrSt=load([P F]);
handles.MaxSt=handles.StrSt(:,2);
handles.MinSt=handles.StrSt(:,1);
else
  warndlg('No Dtat Has been Selected','Plz Enter Data!') ; 
end
hPlotData = plot(handles.FigReg,handles.x1,handles.y1);% select plot
delete(hPlotData);
hPlotData = plot(handles.Fig,handles.x2,handles.y2);% select plot
delete(hPlotData);
cla(handles.FigReg);
cla(handles.Fig);
set(handles.FormFigReg,'visible', 'off');
set(handles.FormFig,'visible', 'off');

handles.DataFileName=F;
handles.DataDirect=P;

set(handles.DataTitle,'String', handles.DataFileName);

set(handles.uitable,'Data',handles.StrSt);
handles.data=get(handles.uitable,'Data');
guidata(hObject, handles);


% --- Executes on button press in PlotReg.
function PlotReg_Callback(hObject, eventdata, handles)
% hObject    handle to PlotReg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles.StrSt=(get(handles.uitable,'Data'));
set(handles.SavePltReg,'visible','on')
set(handles.SaveDone,'visible','off');
hold(handles.FigReg,'off');
hPlotData1 = plot(handles.FigReg,handles.x1,handles.y1);% select plot
delete(hPlotData1);


if isempty(handles.data)
    answer=modaldlgM('Title','Loading Data');
    switch answer
        case 'Yes'
            %*****************
            [F P]=uigetfile({'*.txt','n*2 Data Matrix in Text';'*.m','Data in mFile';...
                '*.mat','Matlab File'},'Load n*2 data matrix');
            handles.DataFileName=F;
handles.DataDirect=P;
            if F
                handles.StrSt=load([P F]);
                handles.MaxSt=handles.StrSt(:,2);
                handles.MinSt=handles.StrSt(:,1);
            else
                warndlg('No Dtat Has been Selected','Plz Enter Data!') ;
            end
            hPlotData = plot(handles.FigReg,handles.x1,handles.y1);% select plot
            delete(hPlotData);
            hPlotData = plot(handles.Fig,handles.x2,handles.y2);% select plot
            delete(hPlotData);
            cla(handles.FigReg);
            cla(handles.Fig);
            set(handles.FormFigReg,'visible', 'off');
            set(handles.FormFig,'visible', 'off');
            
            set(handles.uitable,'Data',handles.StrSt);
            handles.data=get(handles.uitable,'Data');
            %************************
        case 'No'
            
    end
end

if iscell(handles.data); handles.data = cell2mat(handles.data); end

n=length(handles.data);

for i=1:n
    if handles.data(i,1)~=0||handles.data(i,2)~=0
        A(i,1)=handles.data(i,1);
        A(i,2)=handles.data(i,2);
    end
end

handles.MaxSt=A(:,2);
handles.MinSt=A(:,1);
n=length(handles.MaxSt);
handles.C=[];
handles.R=[];
handles.x1=[];
handles.y1=[];
for i=1:n
    handles.C(i)=(handles.MaxSt(i)+handles.MinSt(i))/2;
    handles.R(i)=(handles.MaxSt(i)-handles.MinSt(i))/2;
end

mdl=fitlm(handles.C,handles.R.^2);

AB=mdl.Coefficients;
B=table2array(AB(1,1));%Line Intercept
A=table2array(AB(2,1));%Line Slope
R_Sq=mdl.Rsquared.Ordinary;
size(handles.C);
handles.x1=min(handles.C):0.1:max(handles.C);
handles.y1=A.*handles.x1+B;

scatter(handles.FigReg,handles.C,handles.R.^2);
hold(handles.FigReg,'on');
plot(handles.FigReg,handles.x1,handles.y1);
ylabel (handles.FigReg,'R^2');
xlabel (handles.FigReg,'C');
title(handles.FigReg,'(R=circle"s Radius) & (C=Circle"s Center)','FontSize', 9,'color','r');
legend off;

if B<0
    txt1 ={'Linear Regression Formula:',['R^2 =' num2str(round(A,2)) '.C ' num2str(round(B,2))],['r-Sq =' num2str(round(R_Sq,2))]};
else
    txt1 ={'Linear Regression Formula:',['R^2 =' num2str(round(A,2)) '.C +' num2str(round(B,2))],['r-Sq =' num2str(round(R_Sq,2))]};
end
set(handles.FormFigReg,'visible', 'on');
title(handles.FormFigReg, txt1, 'FontSize', 12);
set(handles.FigReg,'XGrid','on','YGrid','on');
hold(handles.FigReg,'off');
guidata(hObject, handles);

% --- Executes on button press in PlotMC.
function PlotMC_Callback(hObject, eventdata, handles)
% hObject    handle to PlotMC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.SaveDone,'visible','off');

set(handles.SaveDone,'visible','off');
hold(handles.Fig,'off');
hPlotData1 = plot(handles.Fig,handles.x2,handles.y2);% select plot
delete(hPlotData1);
cla(handles.Fig)
hPlotData2 = plot(handles.FormFig,handles.x2,handles.y2);% select plot
delete(hPlotData2);
cla(handles.FormFig);
set(handles.FormFig,'visible', 'off');

if isempty(handles.data)
    answer=modaldlgM('Title','Loading Data');
    switch answer
        case 'Yes'
            %*****************
            [F P]=uigetfile({'*.txt','n*2 Data Matrix in Text';'*.m','Data in mFile';...
                '*.mat','Matlab File'},'Load n*2 data matrix');
            handles.DataFileName=F;
handles.DataDirect=P;
            if F
                handles.StrSt=load([P F]);
                handles.MaxSt=handles.StrSt(:,2);
                handles.MinSt=handles.StrSt(:,1);
            else
                warndlg('No Dtat Has been Selected','Plz Enter Data!') ;
            end
            hPlotData = plot(handles.FigReg,handles.x1,handles.y1);% select plot
            delete(hPlotData);
            hPlotData = plot(handles.Fig,handles.x2,handles.y2);% select plot
            delete(hPlotData);
            cla(handles.FigReg);
            cla(handles.Fig);
            set(handles.FormFigReg,'visible', 'off');
            set(handles.FormFig,'visible', 'off');
            
            set(handles.uitable,'Data',handles.StrSt);
            handles.data=get(handles.uitable,'Data');
            %************************
        case 'No'
            
    end
end


if iscell(handles.data); handles.data = cell2mat(handles.data); end

n=length(handles.data);
for i=1:n
    if handles.data(i,1)~=0||handles.data(i,2)~=0
        A(i,1)=handles.data(i,1);
        A(i,2)=handles.data(i,2);
    end
end
%disp(A)



handles.MaxSt=A(:,2);
handles.MinSt=A(:,1);
n=length(handles.MaxSt);
handles.C=[];
handles.R=[];
handles.x2=[];
handles.y2=[];

for i=1:n
    handles.C(i)=(handles.MaxSt(i)+handles.MinSt(i))/2;
    handles.R(i)=(handles.MaxSt(i)-handles.MinSt(i))/2;
end
XLimit=min(handles.data(:))-0.1*(max(handles.data(:))-min(handles.data(:)));
for i=1:n
    handles.x2=handles.MinSt(i):0.1:handles.MaxSt(i);
    handles.y2=sqrt(handles.R(i).^2-(handles.x2-handles.C(i)).^2);
    plot(handles.Fig,handles.x2,handles.y2);
    hold(handles.Fig,'on');
    ylabel (handles.Fig,'\tau');
    xlabel (handles.Fig,'\sigma');
set(handles.Fig,'XLim',[XLimit 1.1*max(handles.data(:))],'YLim',[XLimit 1.1*max(handles.data(:))]);
set(handles.Fig,'XGrid','on','YGrid','on');
end
guidata(hObject, handles);


% --- Executes on button press in SavePltReg.
function SavePltReg_Callback(hObject, eventdata, handles)
% hObject    handle to SavePltReg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[F P]=uiputfile({'*.fig','Figures (*.fig)'},'Save Plot as Figure');
NewFig=figure;
NewAx=copyobj(handles.FigReg,NewFig);
set(NewAx,'Units','normalized','Position', [0.12 0.12 0.85 0.75]);
hgsave(NewFig,[P F]);
close(NewFig);

% --- Executes on button press in SavePltMCC.
function SavePltMCC_Callback(hObject, eventdata, handles)
% hObject    handle to SavePltMCC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[F P]=uiputfile({'*.fig','Figures (*.fig)'},'Save Plot as Figure');
NewFig=figure;
NewAx=copyobj(handles.Fig,NewFig);
set(NewAx,'Units','normalized','Position', [0.12 0.12 0.85 0.75]);
hgsave(NewFig,[P F]);
close(NewFig);



% --- Executes on button press in PlotMCC.
function PlotMCC_Callback(hObject, eventdata, handles)
% hObject    handle to PlotMCC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.SaveDone,'visible','off');
hold(handles.Fig,'off');
hPlotData1 = plot(handles.Fig,handles.x2,handles.y2);% select plot
delete(hPlotData1);
cla(handles.Fig)
hPlotData2 = plot(handles.FormFig,handles.x2,handles.y2);% select plot
delete(hPlotData2);


if isempty(handles.data)
    answer=modaldlgM('Title','Loading Data');
    switch answer
        case 'Yes'
            %*****************
            [F P]=uigetfile({'*.txt','n*2 Data Matrix in Text';'*.m','Data in mFile';...
                '*.mat','Matlab File'},'Load n*2 data matrix');
            handles.DataFileName=F;
handles.DataDirect=P;
            if F
                handles.StrSt=load([P F]);
                handles.MaxSt=handles.StrSt(:,2);
                handles.MinSt=handles.StrSt(:,1);
            else
                warndlg('No Dtat Has been Selected','Plz Enter Data!') ;
            end
            hPlotData = plot(handles.FigReg,handles.x1,handles.y1);% select plot
            delete(hPlotData);
            hPlotData = plot(handles.Fig,handles.x2,handles.y2);% select plot
            delete(hPlotData);
            cla(handles.FigReg);
            cla(handles.Fig);
            set(handles.FormFigReg,'visible', 'off');
            set(handles.FormFig,'visible', 'off');
            
            set(handles.uitable,'Data',handles.StrSt);
            handles.data=get(handles.uitable,'Data');
            %************************
        case 'No'
            
    end
end

if iscell(handles.data); handles.data = cell2mat(handles.data); end

n=length(handles.data);
for i=1:n
    if handles.data(i,1)~=0||handles.data(i,2)~=0
        A(i,1)=handles.data(i,1);
        A(i,2)=handles.data(i,2);
    end
end
%disp(A)


handles.MaxSt=A(:,2);
handles.MinSt=A(:,1);
n=length(handles.MaxSt);
handles.C=[];
handles.R=[];
handles.x2=[];
handles.y2=[];

for i=1:n
    handles.C(i)=(handles.MaxSt(i)+handles.MinSt(i))/2;
    handles.R(i)=(handles.MaxSt(i)-handles.MinSt(i))/2;
end
XLimit=min(handles.data(:))-0.1*(max(handles.data(:))-min(handles.data(:)));
for i=1:n
    handles.x2=handles.MinSt(i):0.1:handles.MaxSt(i);
    handles.y2=sqrt(handles.R(i).^2-(handles.x2-handles.C(i)).^2);
    plot(handles.Fig,handles.x2,handles.y2);
    hold(handles.Fig,'on');
set(handles.Fig,'XLim',[XLimit 1.1*max(handles.data(:))],'YLim',[XLimit 1.1*max(handles.data(:))]);
end

mdl=fitlm(handles.C,handles.R.^2);
AB=mdl.Coefficients;
B=table2array(AB(1,1));%Line Intercept
A=table2array(AB(2,1));%Line Slope
D=(A.^2/4+B);
Sigma=(-D/A):0.1:max(handles.MaxSt);

%get value for edit
handles.Aedit=A;
handles.Dedit=D;

Tau=sqrt(A.*Sigma+D);

plot(handles.Fig,Sigma, Tau,'k','linewidth',2);

ylabel (handles.Fig,'\tau');
xlabel (handles.Fig,'\sigma');
title(handles.Fig,'Mohr Circles and Cover Curve','color','b');
legend off;
set(handles.Fig,'XGrid','on','YGrid','on');
hold(handles.Fig,'off');

if D<0
txt2 ={'Non-Linear Cover Curve Formula:',['\tau = \surd [',num2str(round(A,2)),'.\sigma ',num2str(round(D,2)),']']};
else
txt2 ={'Non-Linear Cover Curve Formula:',['\tau = \surd [',num2str(round(A,2)),'.\sigma + ',num2str(round(D,2)),']']};    
end

set(handles.FormFig,'visible', 'on');
title(handles.FormFig, txt2, 'FontSize', 12);

set(handles.EditA,'String',num2str(round(A,2)));
set(handles.EditA,'Value',(round(A,2)));
set(handles.EditD,'String',num2str(round(D,2)));
set(handles.EditD,'Value',(round(D,2)));
guidata(hObject, handles);



% --------------------------------------------------------------------
function SaveGUi_Callback(hObject, eventdata, handles)
% hObject    handle to SaveGUi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[F P]=uigetfile({'*.txt','n*2 Data Matrix in Text';'*.m','Data in mFile';...
    '*.mat','Matlab File'},'Load n*2 data matrix');
if F
handles.StrSt=load([P F]);
handles.MaxSt=handles.StrSt(:,2);
handles.MinSt=handles.StrSt(:,1);
else
  warndlg('No Dtat Has been Selected','Plz Enter Data!') ; 
end
hPlotData = plot(handles.FigReg,handles.x1,handles.y1);% select plot
delete(hPlotData);
hPlotData = plot(handles.Fig,handles.x2,handles.y2);% select plot
delete(hPlotData);
cla(handles.FigReg);
cla(handles.Fig);
set(handles.FormFigReg,'visible', 'off');
set(handles.FormFig,'visible', 'off');

set(handles.uitable,'Data',handles.StrSt);
handles.data=get(handles.uitable,'Data');
guidata(hObject, handles);

% --------------------------------------------------------------------
function SelectData_Callback(hObject, eventdata, handles)
% hObject    handle to SelectData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[F P]=uigetfile({'*.txt','n*2 Data Matrix in Text';'*.m','Data in mFile';...
    '*.mat','Matlab File'},'Load n*2 data matrix');
if F
handles.StrSt=load([P F]);
handles.MaxSt=handles.StrSt(:,2);
handles.MinSt=handles.StrSt(:,1);
else
  warndlg('No Dtat Has been Selected','Plz Enter Data!') ; 
end
hPlotData = plot(handles.FigReg,handles.x1,handles.y1);% select plot
delete(hPlotData);
hPlotData = plot(handles.Fig,handles.x2,handles.y2);% select plot
delete(hPlotData);
cla(handles.FigReg);
cla(handles.Fig);
set(handles.FormFigReg,'visible', 'off');
set(handles.FormFig,'visible', 'off');

set(handles.uitable,'Data',handles.StrSt);
handles.data=get(handles.uitable,'Data');
guidata(hObject, handles);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in uitable.
function uitable_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)

handles.StrSt=(get(hObject,'Data'));
Answer=class(handles.StrSt);
if strcmpi(Answer,'cell')==1
handles.StrSt=str2double(get(hObject,'Data'));
%handles.StrSts = cell2mat(handles.StrSt); end
end
%disp(handles.StrSt);
n=length(handles.StrSt)
j=1;
for i=1:n
    if isnan(handles.StrSt(i,1))==0;
        A(j,:)=handles.StrSt(i,:);
        j=j+1;
        handles.data=A;
    end

end

%handles.StrSt=str2double(get(hObject,'Data'));
handles.MaxSt=handles.data(:,2);
handles.MinSt=handles.data(:,1);
guidata(hObject, handles);


% --- Executes on button press in Add.
function Add_Callback(hObject, eventdata, handles)
% hObject    handle to Add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles.StrSt=get(handles.uitable,'Data');
if iscell(handles.data); handles.data = cell2mat(handles.data); end
if isempty(handles.data)
    handles.data=get(handles.uitable,'Data');
end

if (any(handles.data))~=0;
    handles.data(end+1,:)=0;
    handles.Nrows=handles.Nrows+1;
    set(handles.uitable,'Data',handles.data);
else
    handles.Nrows=handles.Nrows+1;
    handles.Ncolumns=2;
    set(handles.uitable,'Data',cell(handles.Nrows,handles.Ncolumns));
end
handles.MaxSt=handles.data(:,2);
handles.MinSt=handles.data(:,1);

guidata(hObject, handles);

% --- Executes on button press in Delete.
function Delete_Callback(hObject, eventdata, handles)
% hObject    handle to Delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles.StrSt=get(handles.uitable,'Data')
if iscell(handles.data); handles.data = cell2mat(handles.data); end
if isempty(handles.data);
    handles.data=get(handles.uitable,'Data');
end

if (any(handles.data))~=0;
    
    handles.data(end,:)=[];
    handles.Nrows=handles.Nrows-1;
    if handles.Nrows<0
        handles.Nrows=0;
    end
    set(handles.uitable,'Data',handles.data);
else
    handles.Nrows=handles.Nrows-1;
    handles.Ncolumns=2;
    if handles.Nrows<0
        handles.Nrows=0;
    end
    set(handles.uitable,'Data',cell(handles.Nrows,handles.Ncolumns));
end
handles.MaxSt=handles.data(:,2);
handles.MinSt=handles.data(:,1);
guidata(hObject, handles);


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in web.
function web_Callback(hObject, eventdata, handles)
% hObject    handle to web (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web('https://www.researchgate.net/project/New-Non-Linear-Simple-Shear-Failure-Criteria-for-Intact-Rocks');


% --- Executes on button press in RegS1S3.
function RegS1S3_Callback(hObject, eventdata, handles)
% hObject    handle to RegS1S3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.SavePltReg,'visible','on')
set(handles.SaveDone,'visible','off');
hold(handles.FigReg,'off');
hPlotData1 = plot(handles.FigReg,handles.x1,handles.y1);% select plot
delete(hPlotData1);

if isempty(handles.data)
    answer=modaldlgM('Title','Loading Data');
    switch answer
        case 'Yes'
            %*****************
            [F P]=uigetfile({'*.txt','n*2 Data Matrix in Text';'*.m','Data in mFile';...
                '*.mat','Matlab File'},'Load n*2 data matrix');
            
handles.DataFileName=F;
handles.DataDirect=P;
            if F
                handles.StrSt=load([P F]);
                handles.MaxSt=handles.StrSt(:,2);
                handles.MinSt=handles.StrSt(:,1);
            else
                warndlg('No Dtat Has been Selected','Plz Enter Data!') ;
            end
            hPlotData = plot(handles.FigReg,handles.x1,handles.y1);% select plot
            delete(hPlotData);
            hPlotData = plot(handles.Fig,handles.x2,handles.y2);% select plot
            delete(hPlotData);
            cla(handles.FigReg);
            cla(handles.Fig);
            set(handles.FormFigReg,'visible', 'off');
            set(handles.FormFig,'visible', 'off');
            
            set(handles.uitable,'Data',handles.StrSt);
            handles.data=get(handles.uitable,'Data');
            %************************
        case 'No'
            
    end
end

if iscell(handles.data); handles.data = cell2mat(handles.data); end

n=length(handles.data);

for i=1:n
    if handles.data(i,1)~=0||handles.data(i,2)~=0
        A(i,1)=handles.data(i,1);
        A(i,2)=handles.data(i,2);
    end
end

handles.MaxSt=A(:,2);
handles.MinSt=A(:,1);
n=length(handles.MaxSt);
handles.C=[];
handles.R=[];
handles.x1=[];
handles.y1=[];

mdl=fitlm(handles.MinSt,handles.MaxSt);

AB=mdl.Coefficients;
B=table2array(AB(1,1));%Line Intercept
A=table2array(AB(2,1));%Line Slope
R_Sq=mdl.Rsquared.Ordinary;
size(handles.MinSt);
handles.x1=min(handles.MinSt):0.1:max(handles.MinSt);
handles.y1=A.*handles.x1+B;

scatter(handles.FigReg,handles.MinSt,handles.MaxSt);
hold(handles.FigReg,'on');
plot(handles.FigReg,handles.x1,handles.y1);
ylabel (handles.FigReg,'\sigma1');
xlabel (handles.FigReg,'\sigma3');
SigmaC=B;
Nphi=A;
Pesi=atan(A)*180/pi;
Phi=asin((Nphi-1)/(Nphi+1))*180/pi;
Coh=SigmaC*(1-sin(Phi*pi/180))/(2*cos(Phi*pi/180));

title(handles.FigReg,['\phi= ' num2str(round(Phi,2)) '^{\circ} & Cohesion=' num2str(round(Coh,2))],'FontSize', 12,'color','r');
legend off;

if B<0
    txt1 ={'\sigma1= \sigma3 . N\phi + \sigmac',['Formula: \sigma1 =' num2str(round(A,2)) '. \sigma3 ' num2str(round(B,2))],['r-Sq =' num2str(round(R_Sq,2))]};
else
    txt1 ={'\sigma1= \sigma3 . N\phi + \sigmac',['Formula: \sigma1 =' num2str(round(A,2)) '. \sigma3 +' num2str(round(B,2))],['r-Sq =' num2str(round(R_Sq,2))]};
end
set(handles.FormFigReg,'visible', 'on');
title(handles.FormFigReg, txt1, 'FontSize', 12);
set(handles.FigReg,'XGrid','on','YGrid','on');
hold(handles.FigReg,'off');
guidata(hObject, handles);

% --- Executes on button press in PlotMC.
function PlotRC_Callback(hObject, eventdata, handles)
% hObject    handle to PlotMC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hold(handles.Fig,'off');
hPlotData1 = plot(handles.Fig,handles.x2,handles.y2);% select plot
delete(hPlotData1);
cla(handles.Fig)
hPlotData2 = plot(handles.FormFig,handles.x2,handles.y2);% select plot
delete(hPlotData2);
cla(handles.FormFig);
set(handles.FormFig,'visible', 'off');

if isempty(handles.data)
    answer=modaldlgM('Title','Loading Data');
    switch answer
        case 'Yes'
            %*****************
            [F P]=uigetfile({'*.txt','n*2 Data Matrix in Text';'*.m','Data in mFile';...
                '*.mat','Matlab File'},'Load n*2 data matrix');
            if F
                handles.StrSt=load([P F]);
                handles.MaxSt=handles.StrSt(:,2);
                handles.MinSt=handles.StrSt(:,1);
            else
                warndlg('No Dtat Has been Selected','Plz Enter Data!') ;
            end
            hPlotData = plot(handles.FigReg,handles.x1,handles.y1);% select plot
            delete(hPlotData);
            hPlotData = plot(handles.Fig,handles.x2,handles.y2);% select plot
            delete(hPlotData);
            cla(handles.FigReg);
            cla(handles.Fig);
            set(handles.FormFigReg,'visible', 'off');
            set(handles.FormFig,'visible', 'off');
            
            set(handles.uitable,'Data',handles.StrSt);
            handles.data=get(handles.uitable,'Data');
            %************************
        case 'No'
            
    end
end


if iscell(handles.data); handles.data = cell2mat(handles.data); end

n=length(handles.data);
for i=1:n
    if handles.data(i,1)~=0||handles.data(i,2)~=0
        A(i,1)=handles.data(i,1);
        A(i,2)=handles.data(i,2);
    end
end
%disp(A)
handles.MaxSt=A(:,2);
handles.MinSt=A(:,1);
n=length(handles.MaxSt);
handles.C=[];
handles.R=[];
handles.x2=[];
handles.y2=[];

for i=1:n
    handles.C(i)=(handles.MaxSt(i)+handles.MinSt(i))/2;
    handles.R(i)=(handles.MaxSt(i)-handles.MinSt(i))/2;
end
XLimit=min(handles.data(:))-0.1*(max(handles.data(:))-min(handles.data(:)));
for i=1:n
    handles.x2=handles.MinSt(i):0.1:handles.MaxSt(i);
    handles.y2=sqrt(handles.R(i).^2-(handles.x2-handles.C(i)).^2);
    plot(handles.Fig,handles.x2,handles.y2);
    hold(handles.Fig,'on');
    ylabel (handles.Fig,'\tau');
    xlabel (handles.Fig,'\sigma');
set(handles.Fig,'XLim',[XLimit 1.1*max(handles.data(:))],'YLim',[XLimit 1.1*max(handles.data(:))]);
set(handles.Fig,'XGrid','on','YGrid','on');
end
guidata(hObject, handles);


% --- Executes on button press in DrawCL.
function DrawCL_Callback(hObject, eventdata, handles)
% hObject    handle to DrawCL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.SaveDone,'visible','off');
hold(handles.Fig,'off');
hPlotData1 = plot(handles.Fig,handles.x2,handles.y2);% select plot
delete(hPlotData1);
cla(handles.Fig)
hPlotData2 = plot(handles.FormFig,handles.x2,handles.y2);% select plot
delete(hPlotData2);

if isempty(handles.data)
    answer=modaldlgM('Title','Loading Data');
    switch answer
        case 'Yes'
            %*****************
            [F P]=uigetfile({'*.txt','n*2 Data Matrix in Text';'*.m','Data in mFile';...
                '*.mat','Matlab File'},'Load n*2 data matrix');
            handles.DataFileName=F;
handles.DataDirect=P;
            if F
                handles.StrSt=load([P F]);
                handles.MaxSt=handles.StrSt(:,2);
                handles.MinSt=handles.StrSt(:,1);
            else
                warndlg('No Dtat Has been Selected','Plz Enter Data!') ;
            end
            hPlotData = plot(handles.FigReg,handles.x1,handles.y1);% select plot
            delete(hPlotData);
            hPlotData = plot(handles.Fig,handles.x2,handles.y2);% select plot
            delete(hPlotData);
            cla(handles.FigReg);
            cla(handles.Fig);
            set(handles.FormFigReg,'visible', 'off');
            set(handles.FormFig,'visible', 'off');
            
            set(handles.uitable,'Data',handles.StrSt);
            handles.data=get(handles.uitable,'Data');
            %************************
        case 'No'
            
    end
end

if iscell(handles.data); handles.data = cell2mat(handles.data); end


n=length(handles.data);
for i=1:n
    if handles.data(i,1)~=0||handles.data(i,2)~=0
        A(i,1)=handles.data(i,1);
        A(i,2)=handles.data(i,2);
    end
end


handles.MaxSt=A(:,2);
handles.MinSt=A(:,1);
n=length(handles.MaxSt);
handles.C=[];
handles.R=[];
handles.x2=[];
handles.y2=[];

for i=1:n
    handles.C(i)=(handles.MaxSt(i)+handles.MinSt(i))/2;
    handles.R(i)=(handles.MaxSt(i)-handles.MinSt(i))/2;
end
 XLimit=min(handles.data(:))-0.1*(max(handles.data(:))-min(handles.data(:)));

mdl=fitlm(handles.MinSt,handles.MaxSt);

AB=mdl.Coefficients;
B=table2array(AB(1,1));%Line Intercept
A=table2array(AB(2,1));%Line Slope
R_Sq=mdl.Rsquared.Ordinary;
size(handles.MinSt);

SigmaC=B;
Nphi=A;
Pesi=atan(A)*180/pi;
Fi=asin((Nphi-1)/(Nphi+1))*180/pi;
Ci=SigmaC*(1-sin(Fi*pi/180))/(2*cos(Fi*pi/180));

handles.x1=min(handles.MinSt):0.1:mean(handles.MaxSt);
handles.y1=tan(Fi*pi/180).*handles.x1+Ci;

for i=1:n
    handles.x2=handles.MinSt(i):0.1:handles.MaxSt(i);
    handles.y2=sqrt(handles.R(i).^2-(handles.x2-handles.C(i)).^2);
    plot(handles.Fig,handles.x2,handles.y2);
    hold(handles.Fig,'on');
set(handles.Fig,'XLim',[XLimit 1.1*max(handles.data(:))],'YLim',[XLimit 1.1*max(handles.data(:))]);
end

plot(handles.Fig,handles.x1, handles.y1,'b','linewidth',2);

ylabel (handles.Fig,'\tau');
xlabel (handles.Fig,'\sigma');
title(handles.Fig,['\phi= ' num2str(round(Fi,2)) '^{\circ}, Cohesion=' num2str(round(Ci,2)), ', UCS= ' num2str(round(SigmaC,2))],'FontSize',12,'color','b');
legend off;
set(handles.Fig,'XGrid','on','YGrid','on');
hold(handles.Fig,'off');

if B<0
txt2 ={'Mohr-Coulomb Formula:',['\tau = ',num2str(round(tan(Fi*pi/180),2)),' .\sigman ',num2str(round(Ci,2))]};
else
txt2 ={'Mohr-Coulomb Formula:',['\tau = ',num2str(round(tan(Fi*pi/180),2)),' .\sigman + ',num2str(round(Ci,2))]};    
end

set(handles.FormFig,'visible', 'on');
title(handles.FormFig, txt2, 'FontSize', 12);

set(handles.EditCoh,'String',num2str(round(Ci,2)));
set(handles.EditCoh,'Value',(round(Ci,2)));
set(handles.EditFric,'String',num2str(round(Fi,2)));
set(handles.EditFric,'Value',(round(Fi,2)));

guidata(hObject, handles);

% --- Executes on button press in PlotMC.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to PlotMC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in PlotMC.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to PlotMC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in HoekCC.
function HoekCC_Callback(hObject, eventdata, handles)
% hObject    handle to HoekCC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.SaveDone,'visible','off');
hold(handles.Fig,'off');
hPlotData1 = plot(handles.Fig,handles.x2,handles.y2);% select plot
delete(hPlotData1);
cla(handles.Fig)
hPlotData2 = plot(handles.FormFig,handles.x2,handles.y2);% select plot
delete(hPlotData2);


if isempty(handles.data)
    answer=modaldlgM('Title','Loading Data');
    switch answer
        case 'Yes'
            %*****************
            [F P]=uigetfile({'*.txt','n*2 Data Matrix in Text';'*.m','Data in mFile';...
                '*.mat','Matlab File'},'Load n*2 data matrix');
            
handles.DataFileName=F;
handles.DataDirect=P;
            if F
                handles.StrSt=load([P F]);
                handles.MaxSt=handles.StrSt(:,2);
                handles.MinSt=handles.StrSt(:,1);
            else
                warndlg('No Dtat Has been Selected','Plz Enter Data!') ;
            end
            hPlotData = plot(handles.FigReg,handles.x1,handles.y1);% select plot
            delete(hPlotData);
            hPlotData = plot(handles.Fig,handles.x2,handles.y2);% select plot
            delete(hPlotData);
            cla(handles.FigReg);
            cla(handles.Fig);
            set(handles.FormFigReg,'visible', 'off');
            set(handles.FormFig,'visible', 'off');
            
            set(handles.uitable,'Data',handles.StrSt);
            handles.data=get(handles.uitable,'Data');
            %************************
        case 'No'
            
    end
end

if iscell(handles.data); handles.data = cell2mat(handles.data); end

n=length(handles.data);
for i=1:n
    if handles.data(i,1)~=0||handles.data(i,2)~=0
        A(i,1)=handles.data(i,1);
        A(i,2)=handles.data(i,2);
    end
end

handles.MaxSt=A(:,2);
handles.MinSt=A(:,1);
n=length(handles.MaxSt);
handles.C=[];
handles.R=[];
handles.x=[];
handles.y=[];
handles.x2=[];
handles.y2=[];


for i=1:n
    handles.C(i)=(handles.MaxSt(i)+handles.MinSt(i))/2;
    handles.R(i)=(handles.MaxSt(i)-handles.MinSt(i))/2;
end
XLimit=min(handles.data(:))-0.1*(max(handles.data(:))-min(handles.data(:)));
for i=1:n
    handles.x2=handles.MinSt(i):0.1:handles.MaxSt(i);
    handles.y2=sqrt(handles.R(i).^2-(handles.x2-handles.C(i)).^2);
    plot(handles.Fig,handles.x2,handles.y2);
    hold(handles.Fig,'on');
set(handles.Fig,'XLim',[XLimit 1.1*max(handles.data(:))],'YLim',[XLimit 1.1*max(handles.data(:))]);
end


for i=1:n
    handles.x(i)=handles.MinSt(i);
    handles.y(i)=(handles.MaxSt(i)-handles.MinSt(i))^2;
end

mdl=fitlm(handles.x,handles.y);

AB=mdl.Coefficients;
B=table2array(AB(1,1));%Line Intercept
A=table2array(AB(2,1));%Line Slope
R_Sq=mdl.Rsquared.Ordinary;
size(handles.x);

mi=A/sqrt(B);
sigci=sqrt(B);
k=(abs(max(handles.MaxSt)/2)-abs(min((handles.MinSt))));
for i=1:k
    sigma3(i)=(-(sigci/mi+1))+i;
    sigma1(i)=sigma3(i)+sigci*(mi*(sigma3(i)/sigci)+1)^0.5;
end

k=length(sigma3);
for i=1:k
    Balmer(i)=1+0.5*mi*(((mi*sigma3(i)/sigci)+1)+eps)^(-.5);
    Sigman(i)=(sigma1(i)+sigma3(i))/2-(sigma1(i)-sigma3(i))/2*((Balmer(i)-1)/(Balmer(i)+1));
    Taun(i)=(sigma1(i)-sigma3(i))*sqrt(Balmer(i))/(Balmer(i)+1);
end
%dlmwrite('balmer.txt',Balmer);

plot(handles.Fig,Sigman, Taun,'r','linewidth',2);

ylabel (handles.Fig,'\tau');
xlabel (handles.Fig,'\sigma');
title(handles.Fig,'Mohr Circles and Nonlinear failure envelope','color','b');
legend off;
set(handles.Fig,'XGrid','on','YGrid','on');
hold(handles.Fig,'off');


txt2 ={'Hoek-Brown \tau-\sigma curve (Balmer Eq.)',['mi= ',num2str(round(mi,2)),', \sigmaci= ',num2str(round(sigci,2)),' ,S=1 , a=0.5']};


set(handles.FormFig,'visible', 'on');
title(handles.FormFig, txt2, 'FontSize', 12);

guidata(hObject, handles);


% --- Executes on button press in CalcMi.
function CalcMi_Callback(hObject, eventdata, handles)
% hObject    handle to CalcMi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.SavePltReg,'visible','on')
set(handles.SaveDone,'visible','off');
hold(handles.FigReg,'off');
hPlotData1 = plot(handles.FigReg,handles.x1,handles.y1);% select plot
delete(hPlotData1);

if isempty(handles.data)
    answer=modaldlgM('Title','Loading Data');
    switch answer
        case 'Yes'
            %*****************
            [F P]=uigetfile({'*.txt','n*2 Data Matrix in Text';'*.m','Data in mFile';...
                '*.mat','Matlab File'},'Load n*2 data matrix');
            handles.DataFileName=F;
handles.DataDirect=P;
            if F
                handles.StrSt=load([P F]);
                handles.MaxSt=handles.StrSt(:,2);
                handles.MinSt=handles.StrSt(:,1);
            else
                warndlg('No Dtat Has been Selected','Plz Enter Data!') ;
            end
            hPlotData = plot(handles.FigReg,handles.x1,handles.y1);% select plot
            delete(hPlotData);
            hPlotData = plot(handles.Fig,handles.x2,handles.y2);% select plot
            delete(hPlotData);
            cla(handles.FigReg);
            cla(handles.Fig);
            set(handles.FormFigReg,'visible', 'off');
            set(handles.FormFig,'visible', 'off');        
            set(handles.uitable,'Data',handles.StrSt);
            handles.data=get(handles.uitable,'Data');
            %************************
        case 'No'      
    end
end

if iscell(handles.data); handles.data = cell2mat(handles.data); end

n=length(handles.data);

for i=1:n
    if handles.data(i,1)~=0||handles.data(i,2)~=0
        A(i,1)=handles.data(i,1);
        A(i,2)=handles.data(i,2);
    end
end


handles.MaxSt=A(:,2);
handles.MinSt=A(:,1);
n=length(handles.MaxSt);
handles.x=[];
handles.y=[];

for i=1:n
    handles.x(i)=handles.MinSt(i);
    handles.y(i)=(handles.MaxSt(i)-handles.MinSt(i))^2;
end

mdl=fitlm(handles.x,handles.y);

AB=mdl.Coefficients;
B=table2array(AB(1,1));%Line Intercept
A=table2array(AB(2,1));%Line Slope
R_Sq=mdl.Rsquared.Ordinary;
size(handles.x);
handles.x1=min(handles.x):0.1:max(handles.x);
handles.y1=A.*handles.x1+B;

scatter(handles.FigReg,handles.x,handles.y);
hold(handles.FigReg,'on');
plot(handles.FigReg,handles.x1,handles.y1);
ylabel (handles.FigReg,'(\sigma1-\sigma3)^2');
xlabel (handles.FigReg,'\sigma3');

title(handles.FigReg,['mi= ' num2str(round(A/sqrt(B),2)) '  &  \sigmaci=' num2str(round(sqrt(B),2))],'FontSize', 12,'color','r');
legend off;

if B<0
    txt1 ={'(\sigma1-\sigma3)^2 = mi .\sigmaci .\sigma3 +\sigmaci^2',['(\sigma1-\sigma3)^2 =' num2str(round(A,2)) '. \sigma3 ' num2str(round(B,2))],['r-Sq =' num2str(round(R_Sq,2))]};
else
    txt1 ={'(\sigma1-\sigma3)^2 = mi .\sigmaci .\sigma3 +\sigmaci^2',['(\sigma1-\sigma3)^2 =' num2str(round(A,2)) '. \sigma3 +' num2str(round(B,2))],['r-Sq =' num2str(round(R_Sq,2))]};
end
set(handles.FormFigReg,'visible', 'on');
title(handles.FormFigReg, txt1, 'FontSize', 12);
set(handles.FigReg,'XGrid','on','YGrid','on');
hold(handles.FigReg,'off');
guidata(hObject, handles);



function EditA_Callback(hObject, eventdata, handles)
% hObject    handle to EditA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditA as text
%        str2double(get(hObject,'String')) returns contents of EditA as a double

D=get(handles.EditD,'Value');
A=get(hObject,'String');
A=str2double(A);

n=length(handles.MaxSt);
handles.C=[];
handles.R=[];
handles.x2=[];
handles.y2=[];
for i=1:n
    handles.C(i)=(handles.MaxSt(i)+handles.MinSt(i))/2;
    handles.R(i)=(handles.MaxSt(i)-handles.MinSt(i))/2;
end
XLimit=min(handles.data(:))-0.1*(max(handles.data(:))-min(handles.data(:)));
for i=1:n
    handles.x2=handles.MinSt(i):0.1:handles.MaxSt(i);
    handles.y2=sqrt(handles.R(i).^2-(handles.x2-handles.C(i)).^2);
    plot(handles.Fig,handles.x2,handles.y2);
    hold(handles.Fig,'on');
set(handles.Fig,'XLim',[XLimit 1.1*max(handles.data(:))],'YLim',[XLimit 1.1*max(handles.data(:))]);
end


Sigma=(-D/A):0.1:max(handles.MaxSt);
Tau=sqrt(A.*Sigma+D);

plot(handles.Fig,Sigma, Tau,'linewidth',2);

ylabel (handles.Fig,'\tau');
xlabel (handles.Fig,'\sigma');
title(handles.Fig,'Mohr Circles and Cover Curve','color','b');
legend off;
set(handles.Fig,'XGrid','on','YGrid','on');
hold(handles.Fig,'off');

if D<0
txt2 ={'Non-Linear Cover Curve Formula:',['\tau = \surd [',num2str(round(A,2)),'.\sigma ',num2str(round(D,2)),']']};
else
txt2 ={'Non-Linear Cover Curve Formula:',['\tau = \surd [',num2str(round(A,2)),'.\sigma + ',num2str(round(D,2)),']']};    
end

set(handles.FormFig,'visible', 'on');
title(handles.FormFig, txt2, 'FontSize', 12);

set(handles.EditA,'String',num2str(round(A,2)));
set(handles.EditA,'Value',(round(A,2)));

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function EditA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in EdtAinc.
function EdtAinc_Callback(hObject, eventdata, handles)
% hObject    handle to EdtAinc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

D=get(handles.EditD,'Value');
A=get(handles.EditA,'Value');
A=A+1;

n=length(handles.MaxSt);
handles.C=[];
handles.R=[];
handles.x2=[];
handles.y2=[];
for i=1:n
    handles.C(i)=(handles.MaxSt(i)+handles.MinSt(i))/2;
    handles.R(i)=(handles.MaxSt(i)-handles.MinSt(i))/2;
end
XLimit=min(handles.data(:))-0.1*(max(handles.data(:))-min(handles.data(:)));
for i=1:n
    handles.x2=handles.MinSt(i):0.1:handles.MaxSt(i);
    handles.y2=sqrt(handles.R(i).^2-(handles.x2-handles.C(i)).^2);
    plot(handles.Fig,handles.x2,handles.y2);
    hold(handles.Fig,'on');
set(handles.Fig,'XLim',[XLimit 1.1*max(handles.data(:))],'YLim',[XLimit 1.1*max(handles.data(:))]);
end


Sigma=(-D/A):0.1:max(handles.MaxSt);
Tau=sqrt(A.*Sigma+D);

plot(handles.Fig,Sigma, Tau,'linewidth',2);

ylabel (handles.Fig,'\tau');
xlabel (handles.Fig,'\sigma');
title(handles.Fig,'Mohr Circles and Cover Curve','color','b');
legend off;
set(handles.Fig,'XGrid','on','YGrid','on');
hold(handles.Fig,'off');

if D<0
txt2 ={'Non-Linear Cover Curve Formula:',['\tau = \surd [',num2str(round(A,2)),'.\sigma ',num2str(round(D,2)),']']};
else
txt2 ={'Non-Linear Cover Curve Formula:',['\tau = \surd [',num2str(round(A,2)),'.\sigma + ',num2str(round(D,2)),']']};    
end

set(handles.FormFig,'visible', 'on');
title(handles.FormFig, txt2, 'FontSize', 12);

set(handles.EditA,'String',num2str(round(A,2)));
set(handles.EditA,'Value',(round(A,2)));

guidata(hObject, handles);


% --- Executes on button press in EditAdec.
function EditAdec_Callback(hObject, eventdata, handles)
% hObject    handle to EditAdec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

D=get(handles.EditD,'Value');
A=get(handles.EditA,'Value');
A=A-1;

n=length(handles.MaxSt);
handles.C=[];
handles.R=[];
handles.x2=[];
handles.y2=[];
for i=1:n
    handles.C(i)=(handles.MaxSt(i)+handles.MinSt(i))/2;
    handles.R(i)=(handles.MaxSt(i)-handles.MinSt(i))/2;
end
XLimit=min(handles.data(:))-0.1*(max(handles.data(:))-min(handles.data(:)));
for i=1:n
    handles.x2=handles.MinSt(i):0.1:handles.MaxSt(i);
    handles.y2=sqrt(handles.R(i).^2-(handles.x2-handles.C(i)).^2);
    plot(handles.Fig,handles.x2,handles.y2);
    hold(handles.Fig,'on');
set(handles.Fig,'XLim',[XLimit 1.1*max(handles.data(:))],'YLim',[XLimit 1.1*max(handles.data(:))]);
end


Sigma=(-D/A):0.1:max(handles.MaxSt);
Tau=sqrt(A.*Sigma+D);

plot(handles.Fig,Sigma, Tau,'linewidth',2);

ylabel (handles.Fig,'\tau');
xlabel (handles.Fig,'\sigma');
title(handles.Fig,'Mohr Circles and Cover Curve','color','b');
legend off;
set(handles.Fig,'XGrid','on','YGrid','on');
hold(handles.Fig,'off');

if D<0
txt2 ={'Non-Linear Cover Curve Formula:',['\tau = \surd [',num2str(round(A,2)),'.\sigma ',num2str(round(D,2)),']']};
else
txt2 ={'Non-Linear Cover Curve Formula:',['\tau = \surd [',num2str(round(A,2)),'.\sigma + ',num2str(round(D,2)),']']};    
end

set(handles.FormFig,'visible', 'on');
title(handles.FormFig, txt2, 'FontSize', 12);

set(handles.EditA,'String',num2str(round(A,2)));
set(handles.EditA,'Value',(round(A,2)));

guidata(hObject, handles);


function EditD_Callback(hObject, eventdata, handles)
% hObject    handle to EditD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditD as text
%        str2double(get(hObject,'String')) returns contents of EditD as a double

A=get(handles.EditA,'Value');
D=get(hObject,'String');
D=str2double(D);

n=length(handles.MaxSt);
handles.C=[];
handles.R=[];
handles.x2=[];
handles.y2=[];
for i=1:n
    handles.C(i)=(handles.MaxSt(i)+handles.MinSt(i))/2;
    handles.R(i)=(handles.MaxSt(i)-handles.MinSt(i))/2;
end
XLimit=min(handles.data(:))-0.1*(max(handles.data(:))-min(handles.data(:)));
for i=1:n
    handles.x2=handles.MinSt(i):0.1:handles.MaxSt(i);
    handles.y2=sqrt(handles.R(i).^2-(handles.x2-handles.C(i)).^2);
    plot(handles.Fig,handles.x2,handles.y2);
    hold(handles.Fig,'on');
set(handles.Fig,'XLim',[XLimit 1.1*max(handles.data(:))],'YLim',[XLimit 1.1*max(handles.data(:))]);
end


Sigma=(-D/A):0.1:max(handles.MaxSt);
Tau=sqrt(A.*Sigma+D);

plot(handles.Fig,Sigma, Tau,'linewidth',2);

ylabel (handles.Fig,'\tau');
xlabel (handles.Fig,'\sigma');
title(handles.Fig,'Mohr Circles and Cover Curve','color','b');
legend off;
set(handles.Fig,'XGrid','on','YGrid','on');
hold(handles.Fig,'off');

if D<0
txt2 ={'Non-Linear Cover Curve Formula:',['\tau = \surd [',num2str(round(A,2)),'.\sigma ',num2str(round(D,2)),']']};
else
txt2 ={'Non-Linear Cover Curve Formula:',['\tau = \surd [',num2str(round(A,2)),'.\sigma + ',num2str(round(D,2)),']']};    
end

set(handles.FormFig,'visible', 'on');
title(handles.FormFig, txt2, 'FontSize', 12);

set(handles.EditD,'String',num2str(round(D,2)));
set(handles.EditD,'Value',(round(D,2)));

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function EditD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in EditBinc.
function EditBinc_Callback(hObject, eventdata, handles)
% hObject    handle to EditBinc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

D=get(handles.EditD,'Value');
A=get(handles.EditA,'Value');
D=D+1;

n=length(handles.MaxSt);
handles.C=[];
handles.R=[];
handles.x2=[];
handles.y2=[];
for i=1:n
    handles.C(i)=(handles.MaxSt(i)+handles.MinSt(i))/2;
    handles.R(i)=(handles.MaxSt(i)-handles.MinSt(i))/2;
end
XLimit=min(handles.data(:))-0.1*(max(handles.data(:))-min(handles.data(:)));
for i=1:n
    handles.x2=handles.MinSt(i):0.1:handles.MaxSt(i);
    handles.y2=sqrt(handles.R(i).^2-(handles.x2-handles.C(i)).^2);
    plot(handles.Fig,handles.x2,handles.y2);
    hold(handles.Fig,'on');
set(handles.Fig,'XLim',[XLimit 1.1*max(handles.data(:))],'YLim',[XLimit 1.1*max(handles.data(:))]);
end


Sigma=(-D/A):0.1:max(handles.MaxSt);
Tau=sqrt(A.*Sigma+D);

plot(handles.Fig,Sigma, Tau,'linewidth',2);

ylabel (handles.Fig,'\tau');
xlabel (handles.Fig,'\sigma');
title(handles.Fig,'Mohr Circles and Cover Curve','color','b');
legend off;
set(handles.Fig,'XGrid','on','YGrid','on');
hold(handles.Fig,'off');

if D<0
txt2 ={'Non-Linear Cover Curve Formula:',['\tau = \surd [',num2str(round(A,2)),'.\sigma ',num2str(round(D,2)),']']};
else
txt2 ={'Non-Linear Cover Curve Formula:',['\tau = \surd [',num2str(round(A,2)),'.\sigma + ',num2str(round(D,2)),']']};    
end

set(handles.FormFig,'visible', 'on');
title(handles.FormFig, txt2, 'FontSize', 12);

set(handles.EditD,'String',num2str(round(D,2)));
set(handles.EditD,'Value',(round(D,2)));

guidata(hObject, handles);


% --- Executes on button press in EditDdec.
function EditDdec_Callback(hObject, eventdata, handles)
% hObject    handle to EditDdec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

D=get(handles.EditD,'Value');
A=get(handles.EditA,'Value');
D=D-1;

n=length(handles.MaxSt);
handles.C=[];
handles.R=[];
handles.x2=[];
handles.y2=[];
for i=1:n
    handles.C(i)=(handles.MaxSt(i)+handles.MinSt(i))/2;
    handles.R(i)=(handles.MaxSt(i)-handles.MinSt(i))/2;
end
XLimit=min(handles.data(:))-0.1*(max(handles.data(:))-min(handles.data(:)));
for i=1:n
    handles.x2=handles.MinSt(i):0.1:handles.MaxSt(i);
    handles.y2=sqrt(handles.R(i).^2-(handles.x2-handles.C(i)).^2);
    plot(handles.Fig,handles.x2,handles.y2);
    hold(handles.Fig,'on');
set(handles.Fig,'XLim',[XLimit 1.1*max(handles.data(:))],'YLim',[XLimit 1.1*max(handles.data(:))]);
end


Sigma=(-D/A):0.1:max(handles.MaxSt);
Tau=sqrt(A.*Sigma+D);

plot(handles.Fig,Sigma, Tau,'linewidth',2);

ylabel (handles.Fig,'\tau');
xlabel (handles.Fig,'\sigma');
title(handles.Fig,'Mohr Circles and Cover Curve','color','b');
legend off;
set(handles.Fig,'XGrid','on','YGrid','on');
hold(handles.Fig,'off');

if D<0
txt2 ={'Non-Linear Cover Curve Formula:',['\tau = \surd [',num2str(round(A,2)),'.\sigma ',num2str(round(D,2)),']']};
else
txt2 ={'Non-Linear Cover Curve Formula:',['\tau = \surd [',num2str(round(A,2)),'.\sigma + ',num2str(round(D,2)),']']};    
end

set(handles.FormFig,'visible', 'on');
title(handles.FormFig, txt2, 'FontSize', 12);

set(handles.EditD,'String',num2str(round(D,2)));
set(handles.EditD,'Value',(round(D,2)));

guidata(hObject, handles);


% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.SaveDone,'visible','off');
cla(handles.FigReg);
cla(handles.Fig);
set(handles.FigReg,'visible','off')
set(handles.SavePltReg,'visible','off')
set(handles.FormFigReg,'visible','off')

hold(handles.Fig,'off');
hPlotData1 = plot(handles.Fig,handles.x2,handles.y2);% select plot
delete(hPlotData1);
cla(handles.Fig)
hPlotData2 = plot(handles.FormFig,handles.x2,handles.y2);% select plot
delete(hPlotData2);


if isempty(handles.data)
    answer=modaldlgM('Title','Loading Data');
    switch answer
        case 'Yes'
            %*****************
            [F P]=uigetfile({'*.txt','n*2 Data Matrix in Text';'*.m','Data in mFile';...
                '*.mat','Matlab File'},'Load n*2 data matrix');
            handles.DataFileName=F;
handles.DataDirect=P;
            if F
                handles.StrSt=load([P F]);
                handles.MaxSt=handles.StrSt(:,2);
                handles.MinSt=handles.StrSt(:,1);
            else
                warndlg('No Dtat Has been Selected','Plz Enter Data!') ;
            end
            hPlotData = plot(handles.FigReg,handles.x1,handles.y1);% select plot
            delete(hPlotData);
            hPlotData = plot(handles.Fig,handles.x2,handles.y2);% select plot
            delete(hPlotData);
            cla(handles.FigReg);
            cla(handles.Fig);
            set(handles.FormFigReg,'visible', 'off');
            set(handles.FormFig,'visible', 'off');
            
            set(handles.uitable,'Data',handles.StrSt);
            handles.data=get(handles.uitable,'Data');
            %************************
        case 'No'
            
    end
end

if iscell(handles.data); handles.data = cell2mat(handles.data); end

n=length(handles.data);
for i=1:n
    if handles.data(i,1)~=0||handles.data(i,2)~=0
        A(i,1)=handles.data(i,1);
        A(i,2)=handles.data(i,2);
    end
end

handles.MaxSt=A(:,2);
handles.MinSt=A(:,1);
n=length(handles.MaxSt);
handles.C=[];
handles.R=[];
handles.x2=[];
handles.y2=[];
handles.x=[];
handles.y=[];

for i=1:n
    handles.C(i)=(handles.MaxSt(i)+handles.MinSt(i))/2;
    handles.R(i)=(handles.MaxSt(i)-handles.MinSt(i))/2;
end
XLimit=min(handles.data(:))-0.1*(max(handles.data(:))-min(handles.data(:)));
for i=1:n
    handles.x2=handles.MinSt(i):0.1:handles.MaxSt(i);
    handles.y2=sqrt(handles.R(i).^2-(handles.x2-handles.C(i)).^2);
    plot(handles.Fig,handles.x2,handles.y2);
    hold(handles.Fig,'on');
set(handles.Fig,'XLim',[XLimit 1.1*max(handles.data(:))],'YLim',[XLimit 1.1*max(handles.data(:))]);
end

mdl=fitlm(handles.C,handles.R.^2);
AB=mdl.Coefficients;
B=table2array(AB(1,1));%Line Intercept
A=table2array(AB(2,1));%Line Slope
D=(A.^2/4+B);
Sigma=(-D/A):0.1:max(handles.MaxSt);

%get value for edit
handles.Aedit=A;
handles.Dedit=D;
Tau=sqrt(A.*Sigma+D);


%Hoek-Brown-Balmer

for i=1:n
    handles.x(i)=handles.MinSt(i);
    handles.y(i)=(handles.MaxSt(i)-handles.MinSt(i))^2;
end

mdl=fitlm(handles.x,handles.y);

AB2=mdl.Coefficients;
B2=table2array(AB2(1,1));%Line Intercept
A2=table2array(AB2(2,1));%Line Slope
R_Sq=mdl.Rsquared.Ordinary;
size(handles.x);

mi=A2/sqrt(B2);
sigci=sqrt(B2);
k=(abs(max(handles.MaxSt)/2)-abs(min((handles.MinSt))));
for i=1:k
    sigma3(i)=(-(sigci/mi+1))+i;
    sigma1(i)=sigma3(i)+sigci*(mi*(sigma3(i)/sigci)+1)^0.5;
end

k=length(sigma3);
for i=1:k
    Balmer(i)=1+0.5*mi*(((mi*sigma3(i)/sigci)+1)+eps)^(-.5);
    Sigman(i)=(sigma1(i)+sigma3(i))/2-(sigma1(i)-sigma3(i))/2*((Balmer(i)-1)/(Balmer(i)+1));
    Taun(i)=(sigma1(i)-sigma3(i))*sqrt(Balmer(i))/(Balmer(i)+1);
end
%dlmwrite('balmer.txt',Balmer);

%Coulomb Line

mdl=fitlm(handles.MinSt,handles.MaxSt);

AB3=mdl.Coefficients;
B3=table2array(AB3(1,1));%Line Intercept
A3=table2array(AB3(2,1));%Line Slope
R_Sq=mdl.Rsquared.Ordinary;
size(handles.MinSt);

SigmaC=B3;
Nphi=A3;
Pesi=atan(A3)*180/pi;
Fi=asin((Nphi-1)/(Nphi+1))*180/pi;
Ci=SigmaC*(1-sin(Fi*pi/180))/(2*cos(Fi*pi/180));

handles.x1=min(handles.MinSt):0.1:mean(handles.MaxSt);
handles.y1=tan(Fi*pi/180).*handles.x1+Ci;

Hh=(round((max(Sigman)/40)/5)+1)*5;

P1=plot(handles.Fig,Sigma, Tau,'k-','linewidth',2);
hold on
P2=plot(handles.Fig,Sigman, Taun,'r.-','linewidth',0.5);
P2.MarkerIndices = 1:Hh:length(Sigman);
hold on
P3=plot(handles.Fig,handles.x1, handles.y1,'b--','linewidth',1);
ylabel (handles.Fig,'\tau');
xlabel (handles.Fig,'\sigma');
title(handles.Fig,['Mohr Circles & Cover Curves of :' handles.DataFileName],'color','k');
set(handles.Fig,'XGrid','on','YGrid','on');
hold(handles.Fig,'off');
legend([P1,P2,P3],'Parabolic Cover Curve (PCC)','Hoek-Brown-Balmer Cover','Coulomb"s Failur Line');


set(handles.EditA,'String',num2str(round(A,2)));
set(handles.EditA,'Value',(round(A,2)));
set(handles.EditD,'String',num2str(round(D,2)));
set(handles.EditD,'Value',(round(D,2)));
set(handles.EditFric,'String',num2str(round(Fi,2)));
set(handles.EditFric,'Value',(round(Fi,2)));
set(handles.EditCoh,'String',num2str(round(Ci,2)));
set(handles.EditFric,'Value',(round(Ci,2)));
guidata(hObject, handles);


% --- Executes on button press in ExporData.
function ExporData_Callback(hObject, eventdata, handles)
% hObject    handle to ExporData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.FigReg);
cla(handles.Fig);
set(handles.FigReg,'visible','off')
set(handles.SavePltReg,'visible','off')
set(handles.FormFigReg,'visible','off')

hold(handles.Fig,'off');
hPlotData1 = plot(handles.Fig,handles.x2,handles.y2);% select plot
delete(hPlotData1);
cla(handles.Fig)
hPlotData2 = plot(handles.FormFig,handles.x2,handles.y2);% select plot
delete(hPlotData2);


if isempty(handles.data)
    answer=modaldlgM('Title','Loading Data');
    switch answer
        case 'Yes'
            %*****************
            [F P]=uigetfile({'*.txt','n*2 Data Matrix in Text';'*.m','Data in mFile';...
                '*.mat','Matlab File'},'Load n*2 data matrix');
            handles.DataFileName=F;
handles.DataDirect=P;
            if F
                handles.StrSt=load([P F]);
                handles.MaxSt=handles.StrSt(:,2);
                handles.MinSt=handles.StrSt(:,1);
            else
                warndlg('No Dtat Has been Selected','Plz Enter Data!') ;
            end
            hPlotData = plot(handles.FigReg,handles.x1,handles.y1);% select plot
            delete(hPlotData);
            hPlotData = plot(handles.Fig,handles.x2,handles.y2);% select plot
            delete(hPlotData);
            cla(handles.FigReg);
            cla(handles.Fig);
            set(handles.FormFigReg,'visible', 'off');
            set(handles.FormFig,'visible', 'off');
            
            set(handles.uitable,'Data',handles.StrSt);
            handles.data=get(handles.uitable,'Data');
            %************************
        case 'No'
            
    end
end

if iscell(handles.data); handles.data = cell2mat(handles.data); end

n=length(handles.data);
for i=1:n
    if handles.data(i,1)~=0||handles.data(i,2)~=0
        A(i,1)=handles.data(i,1);
        A(i,2)=handles.data(i,2);
    end
end


handles.MaxSt=A(:,2);
handles.MinSt=A(:,1);
n=length(handles.MaxSt);
handles.C=[];
handles.R=[];
handles.x2=[];
handles.y2=[];
handles.x=[];
handles.y=[];

for i=1:n
    handles.C(i)=(handles.MaxSt(i)+handles.MinSt(i))/2;
    handles.R(i)=(handles.MaxSt(i)-handles.MinSt(i))/2;
end
XLimit=min(handles.data(:))-0.1*(max(handles.data(:))-min(handles.data(:)));
for i=1:n
    handles.x2=handles.MinSt(i):0.1:handles.MaxSt(i);
    handles.y2=sqrt(handles.R(i).^2-(handles.x2-handles.C(i)).^2);
    plot(handles.Fig,handles.x2,handles.y2);
    hold(handles.Fig,'on');
set(handles.Fig,'XLim',[XLimit 1.1*max(handles.data(:))],'YLim',[XLimit 1.1*max(handles.data(:))]);
end

mdl=fitlm(handles.C,handles.R.^2);
AB=mdl.Coefficients;
B=table2array(AB(1,1));%Line Intercept
A=table2array(AB(2,1));%Line Slope
D=(A.^2/4+B);
Sigma=(-D/A):0.1:max(handles.MaxSt);

%get value for edit
handles.Aedit=A;
handles.Dedit=D;
Tau=sqrt(A.*Sigma+D);


%Hoek-Brown-Balmer

for i=1:n
    handles.x(i)=handles.MinSt(i);
    handles.y(i)=(handles.MaxSt(i)-handles.MinSt(i))^2;
end

mdl=fitlm(handles.x,handles.y);

AB2=mdl.Coefficients;
B2=table2array(AB2(1,1));%Line Intercept
A2=table2array(AB2(2,1));%Line Slope
R_Sq=mdl.Rsquared.Ordinary;
size(handles.x);

mi=A2/sqrt(B2);
sigci=sqrt(B2);
k=(abs(max(handles.MaxSt)/2)-abs(min((handles.MinSt))));
for i=1:k
    sigma3(i)=(-(sigci/mi+1))+i;
    sigma1(i)=sigma3(i)+sigci*(mi*(sigma3(i)/sigci)+1)^0.5;
end

k=length(sigma3);
for i=1:k
    Balmer(i)=1+0.5*mi*(((mi*sigma3(i)/sigci)+1)+eps)^(-.5);
    Sigman(i)=(sigma1(i)+sigma3(i))/2-(sigma1(i)-sigma3(i))/2*((Balmer(i)-1)/(Balmer(i)+1));
    Taun(i)=(sigma1(i)-sigma3(i))*sqrt(Balmer(i))/(Balmer(i)+1);
end
%dlmwrite('balmer.txt',Balmer);

%Coulomb Line

mdl=fitlm(handles.MinSt,handles.MaxSt);

AB3=mdl.Coefficients;
B3=table2array(AB3(1,1));%Line Intercept
A3=table2array(AB3(2,1));%Line Slope
R_Sq=mdl.Rsquared.Ordinary;
size(handles.MinSt);

SigmaC=B3;
Nphi=A3;
Pesi=atan(A3)*180/pi;
Fi=asin((Nphi-1)/(Nphi+1))*180/pi;
Ci=SigmaC*(1-sin(Fi*pi/180))/(2*cos(Fi*pi/180));

handles.x1=min(handles.MinSt):0.1:mean(handles.MaxSt);
handles.y1=tan(Fi*pi/180).*handles.x1+Ci;

Hh=(round((max(Sigman)/40)/5)+1)*5;

P1=plot(handles.Fig,Sigma, Tau,'k-','linewidth',2);
hold on
P2=plot(handles.Fig,Sigman, Taun,'r.-','linewidth',0.5);
P2.MarkerIndices = 1:Hh:length(Sigman);
hold on
P3=plot(handles.Fig,handles.x1, handles.y1,'b--','linewidth',1);
ylabel (handles.Fig,'\tau');
xlabel (handles.Fig,'\sigma');
title(handles.Fig,'Mohr Circles and Cover Curves','color','k');
set(handles.Fig,'XGrid','on','YGrid','on');
hold(handles.Fig,'off');
legend([P1,P2,P3],'Parabolic Cover Curve (PCC)','Hoek-Brown-Balmer Cover','Coulomb"s Failur Line');



PCC_Sigma = round(Sigma',2);
PCC_Tau = round(Tau',2);
PCC_Data=table(PCC_Sigma,PCC_Tau);
writetable(PCC_Data,[handles.DataFileName,'-ParabolicCC.txt']);

HB_Sigma = round(Sigman',2);
HB_Tau = round(Taun',2);
HB_Data=table(HB_Sigma,HB_Tau);
writetable(HB_Data,[handles.DataFileName,'-HB Balmer .txt']);

MC_Sigma =round( handles.x1',2);
MC_Tau = round(handles.y1',2);
MC_Data=table(MC_Sigma,MC_Tau);
writetable(MC_Data,[handles.DataFileName,'-Coulomb.txt']);

set(handles.SaveDone,'visible','on');
set(handles.SaveDone,'String', ['Plot Data saved to following directory: ',handles.DataDirect]);

set(handles.EditA,'String',num2str(round(A,2)));
set(handles.EditA,'Value',(round(A,2)));
set(handles.EditD,'String',num2str(round(D,2)));
set(handles.EditD,'Value',(round(D,2)));
set(handles.EditFric,'String',num2str(round(Fi,2)));
set(handles.EditFric,'Value',(round(Fi,2)));
set(handles.EditCoh,'String',num2str(round(Ci,2)));
set(handles.EditFric,'Value',(round(Ci,2)));
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function FormFigReg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FormFigReg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate FormFigReg


% --- Executes on button press in CohDec.
function CohDec_Callback(hObject, eventdata, handles)
% hObject    handle to CohDec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fi=get(handles.EditFric,'Value');
Ci=get(handles.EditCoh,'Value');
Ci=Ci-1;

hold(handles.Fig,'off');
hPlotData1 = plot(handles.Fig,handles.x2,handles.y2);% select plot
delete(hPlotData1);
cla(handles.Fig)
hPlotData2 = plot(handles.FormFig,handles.x2,handles.y2);% select plot
delete(hPlotData2);

if isempty(handles.data)
    answer=modaldlgM('Title','Loading Data');
    switch answer
        case 'Yes'
            %*****************
            [F P]=uigetfile({'*.txt','n*2 Data Matrix in Text';'*.m','Data in mFile';...
                '*.mat','Matlab File'},'Load n*2 data matrix');
            if F
                handles.StrSt=load([P F]);
                handles.MaxSt=handles.StrSt(:,2);
                handles.MinSt=handles.StrSt(:,1);
            else
                warndlg('No Dtat Has been Selected','Plz Enter Data!') ;
            end
            hPlotData = plot(handles.FigReg,handles.x1,handles.y1);% select plot
            delete(hPlotData);
            hPlotData = plot(handles.Fig,handles.x2,handles.y2);% select plot
            delete(hPlotData);
            cla(handles.FigReg);
            cla(handles.Fig);
            set(handles.FormFigReg,'visible', 'off');
            set(handles.FormFig,'visible', 'off');
            
            set(handles.uitable,'Data',handles.StrSt);
            handles.data=get(handles.uitable,'Data');
            %************************
        case 'No'
            
    end
end

if iscell(handles.data); handles.data = cell2mat(handles.data); end


n=length(handles.data);
for i=1:n
    if handles.data(i,1)~=0||handles.data(i,2)~=0
        A(i,1)=handles.data(i,1);
        A(i,2)=handles.data(i,2);
    end
end
%disp(A)
handles.MaxSt=A(:,2);
handles.MinSt=A(:,1);
n=length(handles.MaxSt);
handles.C=[];
handles.R=[];
handles.x2=[];
handles.y2=[];

for i=1:n
    handles.C(i)=(handles.MaxSt(i)+handles.MinSt(i))/2;
    handles.R(i)=(handles.MaxSt(i)-handles.MinSt(i))/2;
end
 XLimit=min(handles.data(:))-0.1*(max(handles.data(:))-min(handles.data(:)));

mdl=fitlm(handles.MinSt,handles.MaxSt);

AB=mdl.Coefficients;
B=table2array(AB(1,1));%Line Intercept
A=table2array(AB(2,1));%Line Slope
R_Sq=mdl.Rsquared.Ordinary;
size(handles.MinSt);

SigmaC=B;
Nphi=A;
Pesi=atan(A)*180/pi;
% Fi=asin((Nphi-1)/(Nphi+1))*180/pi;
% Ci=SigmaC*(1-sin(Fi*pi/180))/(2*cos(Fi*pi/180));
handles.x1=min(handles.MinSt):0.1:mean(handles.MaxSt);
handles.y1=tan(Fi*pi/180).*handles.x1+Ci;

for i=1:n
    handles.x2=handles.MinSt(i):0.1:handles.MaxSt(i);
    handles.y2=sqrt(handles.R(i).^2-(handles.x2-handles.C(i)).^2);
    plot(handles.Fig,handles.x2,handles.y2);
    hold(handles.Fig,'on');
set(handles.Fig,'XLim',[XLimit 1.1*max(handles.data(:))],'YLim',[XLimit 1.1*max(handles.data(:))]);
end

plot(handles.Fig,handles.x1, handles.y1,'linewidth',2);

ylabel (handles.Fig,'\tau');
xlabel (handles.Fig,'\sigma');
title(handles.Fig,['\phi= ' num2str(round(Fi,2)) '^{\circ}, Cohesion=' num2str(round(Ci,2)), ', UCS= ' num2str(round(SigmaC,2))],'FontSize',12,'color','b');
legend off;
set(handles.Fig,'XGrid','on','YGrid','on');
hold(handles.Fig,'off');

if B<0
txt2 ={'Mohr-Coulomb Formula:',['\tau = ',num2str(round(tan(Fi*pi/180),2)),' .\sigman ',num2str(round(Ci,2))]};
else
txt2 ={'Mohr-Coulomb Formula:',['\tau = ',num2str(round(tan(Fi*pi/180),2)),' .\sigman + ',num2str(round(Ci,2))]};    
end

set(handles.FormFig,'visible', 'on');
title(handles.FormFig, txt2, 'FontSize', 12);


set(handles.EditCoh,'String',num2str(round(Ci,2)));
set(handles.EditCoh,'Value',(round(Ci,2)));

guidata(hObject, handles);



function EditCoh_Callback(hObject, eventdata, handles)
% hObject    handle to EditCoh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditCoh as text
%        str2double(get(hObject,'String')) returns contents of EditCoh as a double

Fi=get(handles.EditFric,'Value');
Ci=get(hObject,'String');
Ci=str2double(Ci); 

hold(handles.Fig,'off');
hPlotData1 = plot(handles.Fig,handles.x2,handles.y2);% select plot
delete(hPlotData1);
cla(handles.Fig)
hPlotData2 = plot(handles.FormFig,handles.x2,handles.y2);% select plot
delete(hPlotData2);

if isempty(handles.data)
    answer=modaldlgM('Title','Loading Data');
    switch answer
        case 'Yes'
            %*****************
            [F P]=uigetfile({'*.txt','n*2 Data Matrix in Text';'*.m','Data in mFile';...
                '*.mat','Matlab File'},'Load n*2 data matrix');
            if F
                handles.StrSt=load([P F]);
                handles.MaxSt=handles.StrSt(:,2);
                handles.MinSt=handles.StrSt(:,1);
            else
                warndlg('No Dtat Has been Selected','Plz Enter Data!') ;
            end
            hPlotData = plot(handles.FigReg,handles.x1,handles.y1);% select plot
            delete(hPlotData);
            hPlotData = plot(handles.Fig,handles.x2,handles.y2);% select plot
            delete(hPlotData);
            cla(handles.FigReg);
            cla(handles.Fig);
            set(handles.FormFigReg,'visible', 'off');
            set(handles.FormFig,'visible', 'off');
            
            set(handles.uitable,'Data',handles.StrSt);
            handles.data=get(handles.uitable,'Data');
            %************************
        case 'No'
            
    end
end

if iscell(handles.data); handles.data = cell2mat(handles.data); end


n=length(handles.data);
for i=1:n
    if handles.data(i,1)~=0||handles.data(i,2)~=0
        A(i,1)=handles.data(i,1);
        A(i,2)=handles.data(i,2);
    end
end
%disp(A)
handles.MaxSt=A(:,2);
handles.MinSt=A(:,1);
n=length(handles.MaxSt);
handles.C=[];
handles.R=[];
handles.x2=[];
handles.y2=[];

for i=1:n
    handles.C(i)=(handles.MaxSt(i)+handles.MinSt(i))/2;
    handles.R(i)=(handles.MaxSt(i)-handles.MinSt(i))/2;
end
 XLimit=min(handles.data(:))-0.1*(max(handles.data(:))-min(handles.data(:)));

mdl=fitlm(handles.MinSt,handles.MaxSt);

AB=mdl.Coefficients;
B=table2array(AB(1,1));%Line Intercept
A=table2array(AB(2,1));%Line Slope
R_Sq=mdl.Rsquared.Ordinary;
size(handles.MinSt);

SigmaC=B;
Nphi=A;
Pesi=atan(A)*180/pi;
% Fi=asin((Nphi-1)/(Nphi+1))*180/pi;
% Ci=SigmaC*(1-sin(Fi*pi/180))/(2*cos(Fi*pi/180));
handles.x1=min(handles.MinSt):0.1:mean(handles.MaxSt);
handles.y1=tan(Fi*pi/180).*handles.x1+Ci;

for i=1:n
    handles.x2=handles.MinSt(i):0.1:handles.MaxSt(i);
    handles.y2=sqrt(handles.R(i).^2-(handles.x2-handles.C(i)).^2);
    plot(handles.Fig,handles.x2,handles.y2);
    hold(handles.Fig,'on');
set(handles.Fig,'XLim',[XLimit 1.1*max(handles.data(:))],'YLim',[XLimit 1.1*max(handles.data(:))]);
end

plot(handles.Fig,handles.x1, handles.y1,'linewidth',2);

ylabel (handles.Fig,'\tau');
xlabel (handles.Fig,'\sigma');
title(handles.Fig,['\phi= ' num2str(round(Fi,2)) '^{\circ}, Cohesion=' num2str(round(Ci,2)), ', UCS= ' num2str(round(SigmaC,2))],'FontSize',12,'color','b');
legend off;
set(handles.Fig,'XGrid','on','YGrid','on');
hold(handles.Fig,'off');

if B<0
txt2 ={'Mohr-Coulomb Formula:',['\tau = ',num2str(round(tan(Fi*pi/180),2)),' .\sigman ',num2str(round(Ci,2))]};
else
txt2 ={'Mohr-Coulomb Formula:',['\tau = ',num2str(round(tan(Fi*pi/180),2)),' .\sigman + ',num2str(round(Ci,2))]};    
end

set(handles.FormFig,'visible', 'on');
title(handles.FormFig, txt2, 'FontSize', 12);


set(handles.EditCoh,'String',num2str(round(Ci,2)));
set(handles.EditCoh,'Value',(round(Ci,2)));

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function EditCoh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditCoh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CohInc.
function CohInc_Callback(hObject, eventdata, handles)
% hObject    handle to CohInc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fi=get(handles.EditFric,'Value');
Ci=get(handles.EditCoh,'Value');
Ci=Ci+1;

hold(handles.Fig,'off');
hPlotData1 = plot(handles.Fig,handles.x2,handles.y2);% select plot
delete(hPlotData1);
cla(handles.Fig)
hPlotData2 = plot(handles.FormFig,handles.x2,handles.y2);% select plot
delete(hPlotData2);

if isempty(handles.data)
    answer=modaldlgM('Title','Loading Data');
    switch answer
        case 'Yes'
            %*****************
            [F P]=uigetfile({'*.txt','n*2 Data Matrix in Text';'*.m','Data in mFile';...
                '*.mat','Matlab File'},'Load n*2 data matrix');
            if F
                handles.StrSt=load([P F]);
                handles.MaxSt=handles.StrSt(:,2);
                handles.MinSt=handles.StrSt(:,1);
            else
                warndlg('No Dtat Has been Selected','Plz Enter Data!') ;
            end
            hPlotData = plot(handles.FigReg,handles.x1,handles.y1);% select plot
            delete(hPlotData);
            hPlotData = plot(handles.Fig,handles.x2,handles.y2);% select plot
            delete(hPlotData);
            cla(handles.FigReg);
            cla(handles.Fig);
            set(handles.FormFigReg,'visible', 'off');
            set(handles.FormFig,'visible', 'off');
            
            set(handles.uitable,'Data',handles.StrSt);
            handles.data=get(handles.uitable,'Data');
            %************************
        case 'No'
            
    end
end

if iscell(handles.data); handles.data = cell2mat(handles.data); end


n=length(handles.data);
for i=1:n
    if handles.data(i,1)~=0||handles.data(i,2)~=0
        A(i,1)=handles.data(i,1);
        A(i,2)=handles.data(i,2);
    end
end
%disp(A)
handles.MaxSt=A(:,2);
handles.MinSt=A(:,1);
n=length(handles.MaxSt);
handles.C=[];
handles.R=[];
handles.x2=[];
handles.y2=[];

for i=1:n
    handles.C(i)=(handles.MaxSt(i)+handles.MinSt(i))/2;
    handles.R(i)=(handles.MaxSt(i)-handles.MinSt(i))/2;
end
 XLimit=min(handles.data(:))-0.1*(max(handles.data(:))-min(handles.data(:)));

mdl=fitlm(handles.MinSt,handles.MaxSt);

AB=mdl.Coefficients;
B=table2array(AB(1,1));%Line Intercept
A=table2array(AB(2,1));%Line Slope
R_Sq=mdl.Rsquared.Ordinary;
size(handles.MinSt);

SigmaC=B;
Nphi=A;
Pesi=atan(A)*180/pi;
% Fi=asin((Nphi-1)/(Nphi+1))*180/pi;
% Ci=SigmaC*(1-sin(Fi*pi/180))/(2*cos(Fi*pi/180));
handles.x1=min(handles.MinSt):0.1:mean(handles.MaxSt);
handles.y1=tan(Fi*pi/180).*handles.x1+Ci;

for i=1:n
    handles.x2=handles.MinSt(i):0.1:handles.MaxSt(i);
    handles.y2=sqrt(handles.R(i).^2-(handles.x2-handles.C(i)).^2);
    plot(handles.Fig,handles.x2,handles.y2);
    hold(handles.Fig,'on');
set(handles.Fig,'XLim',[XLimit 1.1*max(handles.data(:))],'YLim',[XLimit 1.1*max(handles.data(:))]);
end

plot(handles.Fig,handles.x1, handles.y1,'linewidth',2);

ylabel (handles.Fig,'\tau');
xlabel (handles.Fig,'\sigma');
title(handles.Fig,['\phi= ' num2str(round(Fi,2)) '^{\circ}, Cohesion=' num2str(round(Ci,2)), ', UCS= ' num2str(round(SigmaC,2))],'FontSize',12,'color','b');
legend off;
set(handles.Fig,'XGrid','on','YGrid','on');
hold(handles.Fig,'off');

if B<0
txt2 ={'Mohr-Coulomb Formula:',['\tau = ',num2str(round(tan(Fi*pi/180),2)),' .\sigman ',num2str(round(Ci,2))]};
else
txt2 ={'Mohr-Coulomb Formula:',['\tau = ',num2str(round(tan(Fi*pi/180),2)),' .\sigman + ',num2str(round(Ci,2))]};    
end

set(handles.FormFig,'visible', 'on');
title(handles.FormFig, txt2, 'FontSize', 12);


set(handles.EditCoh,'String',num2str(round(Ci,2)));
set(handles.EditCoh,'Value',(round(Ci,2)));

guidata(hObject, handles);



function EditFric_Callback(hObject, eventdata, handles)
% hObject    handle to EditFric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditFric as text
%        str2double(get(hObject,'String')) returns contents of EditFric as a double

Ci=get(handles.EditCoh,'Value');
Fi=get(hObject,'String');
Fi=str2double(Fi); 

hold(handles.Fig,'off');
hPlotData1 = plot(handles.Fig,handles.x2,handles.y2);% select plot
delete(hPlotData1);
cla(handles.Fig)
hPlotData2 = plot(handles.FormFig,handles.x2,handles.y2);% select plot
delete(hPlotData2);

if isempty(handles.data)
    answer=modaldlgM('Title','Loading Data');
    switch answer
        case 'Yes'
            %*****************
            [F P]=uigetfile({'*.txt','n*2 Data Matrix in Text';'*.m','Data in mFile';...
                '*.mat','Matlab File'},'Load n*2 data matrix');
            if F
                handles.StrSt=load([P F]);
                handles.MaxSt=handles.StrSt(:,2);
                handles.MinSt=handles.StrSt(:,1);
            else
                warndlg('No Dtat Has been Selected','Plz Enter Data!') ;
            end
            hPlotData = plot(handles.FigReg,handles.x1,handles.y1);% select plot
            delete(hPlotData);
            hPlotData = plot(handles.Fig,handles.x2,handles.y2);% select plot
            delete(hPlotData);
            cla(handles.FigReg);
            cla(handles.Fig);
            set(handles.FormFigReg,'visible', 'off');
            set(handles.FormFig,'visible', 'off');
            
            set(handles.uitable,'Data',handles.StrSt);
            handles.data=get(handles.uitable,'Data');
            %************************
        case 'No'
            
    end
end

if iscell(handles.data); handles.data = cell2mat(handles.data); end


n=length(handles.data);
for i=1:n
    if handles.data(i,1)~=0||handles.data(i,2)~=0
        A(i,1)=handles.data(i,1);
        A(i,2)=handles.data(i,2);
    end
end
%disp(A)
handles.MaxSt=A(:,2);
handles.MinSt=A(:,1);
n=length(handles.MaxSt);
handles.C=[];
handles.R=[];
handles.x2=[];
handles.y2=[];

for i=1:n
    handles.C(i)=(handles.MaxSt(i)+handles.MinSt(i))/2;
    handles.R(i)=(handles.MaxSt(i)-handles.MinSt(i))/2;
end
 XLimit=min(handles.data(:))-0.1*(max(handles.data(:))-min(handles.data(:)));

mdl=fitlm(handles.MinSt,handles.MaxSt);

AB=mdl.Coefficients;
B=table2array(AB(1,1));%Line Intercept
A=table2array(AB(2,1));%Line Slope
R_Sq=mdl.Rsquared.Ordinary;
size(handles.MinSt);

SigmaC=B;
Nphi=A;
Pesi=atan(A)*180/pi;
% Fi=asin((Nphi-1)/(Nphi+1))*180/pi;
% Ci=SigmaC*(1-sin(Fi*pi/180))/(2*cos(Fi*pi/180));
handles.x1=min(handles.MinSt):0.1:mean(handles.MaxSt);
handles.y1=tan(Fi*pi/180).*handles.x1+Ci;

for i=1:n
    handles.x2=handles.MinSt(i):0.1:handles.MaxSt(i);
    handles.y2=sqrt(handles.R(i).^2-(handles.x2-handles.C(i)).^2);
    plot(handles.Fig,handles.x2,handles.y2);
    hold(handles.Fig,'on');
set(handles.Fig,'XLim',[XLimit 1.1*max(handles.data(:))],'YLim',[XLimit 1.1*max(handles.data(:))]);
end

plot(handles.Fig,handles.x1, handles.y1,'linewidth',2);

ylabel (handles.Fig,'\tau');
xlabel (handles.Fig,'\sigma');
title(handles.Fig,['\phi= ' num2str(round(Fi,2)) '^{\circ}, Cohesion=' num2str(round(Ci,2)), ', UCS= ' num2str(round(SigmaC,2))],'FontSize',12,'color','b');
legend off;
set(handles.Fig,'XGrid','on','YGrid','on');
hold(handles.Fig,'off');

if B<0
txt2 ={'Mohr-Coulomb Formula:',['\tau = ',num2str(round(tan(Fi*pi/180),2)),' .\sigman ',num2str(round(Ci,2))]};
else
txt2 ={'Mohr-Coulomb Formula:',['\tau = ',num2str(round(tan(Fi*pi/180),2)),' .\sigman + ',num2str(round(Ci,2))]};    
end

set(handles.FormFig,'visible', 'on');
title(handles.FormFig, txt2, 'FontSize', 12);


set(handles.EditFric,'String',num2str(round(Fi,2)));
set(handles.EditFric,'Value',(round(Fi,2)));

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function EditFric_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditFric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in FricInc.
function FricInc_Callback(hObject, eventdata, handles)
% hObject    handle to FricInc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fi=get(handles.EditFric,'Value');
Ci=get(handles.EditCoh,'Value');
Fi=Fi+1;

hold(handles.Fig,'off');
hPlotData1 = plot(handles.Fig,handles.x2,handles.y2);% select plot
delete(hPlotData1);
cla(handles.Fig)
hPlotData2 = plot(handles.FormFig,handles.x2,handles.y2);% select plot
delete(hPlotData2);

if isempty(handles.data)
    answer=modaldlgM('Title','Loading Data');
    switch answer
        case 'Yes'
            %*****************
            [F P]=uigetfile({'*.txt','n*2 Data Matrix in Text';'*.m','Data in mFile';...
                '*.mat','Matlab File'},'Load n*2 data matrix');
            if F
                handles.StrSt=load([P F]);
                handles.MaxSt=handles.StrSt(:,2);
                handles.MinSt=handles.StrSt(:,1);
            else
                warndlg('No Dtat Has been Selected','Plz Enter Data!') ;
            end
            hPlotData = plot(handles.FigReg,handles.x1,handles.y1);% select plot
            delete(hPlotData);
            hPlotData = plot(handles.Fig,handles.x2,handles.y2);% select plot
            delete(hPlotData);
            cla(handles.FigReg);
            cla(handles.Fig);
            set(handles.FormFigReg,'visible', 'off');
            set(handles.FormFig,'visible', 'off');
            
            set(handles.uitable,'Data',handles.StrSt);
            handles.data=get(handles.uitable,'Data');
            %************************
        case 'No'
            
    end
end

if iscell(handles.data); handles.data = cell2mat(handles.data); end


n=length(handles.data);
for i=1:n
    if handles.data(i,1)~=0||handles.data(i,2)~=0
        A(i,1)=handles.data(i,1);
        A(i,2)=handles.data(i,2);
    end
end
%disp(A)
handles.MaxSt=A(:,2);
handles.MinSt=A(:,1);
n=length(handles.MaxSt);
handles.C=[];
handles.R=[];
handles.x2=[];
handles.y2=[];

for i=1:n
    handles.C(i)=(handles.MaxSt(i)+handles.MinSt(i))/2;
    handles.R(i)=(handles.MaxSt(i)-handles.MinSt(i))/2;
end
 XLimit=min(handles.data(:))-0.1*(max(handles.data(:))-min(handles.data(:)));

mdl=fitlm(handles.MinSt,handles.MaxSt);

AB=mdl.Coefficients;
B=table2array(AB(1,1));%Line Intercept
A=table2array(AB(2,1));%Line Slope
R_Sq=mdl.Rsquared.Ordinary;
size(handles.MinSt);

SigmaC=B;
Nphi=A;
Pesi=atan(A)*180/pi;
% Fi=asin((Nphi-1)/(Nphi+1))*180/pi;
% Ci=SigmaC*(1-sin(Fi*pi/180))/(2*cos(Fi*pi/180));
handles.x1=min(handles.MinSt):0.1:mean(handles.MaxSt);
handles.y1=tan(Fi*pi/180).*handles.x1+Ci;

for i=1:n
    handles.x2=handles.MinSt(i):0.1:handles.MaxSt(i);
    handles.y2=sqrt(handles.R(i).^2-(handles.x2-handles.C(i)).^2);
    plot(handles.Fig,handles.x2,handles.y2);
    hold(handles.Fig,'on');
set(handles.Fig,'XLim',[XLimit 1.1*max(handles.data(:))],'YLim',[XLimit 1.1*max(handles.data(:))]);
end

plot(handles.Fig,handles.x1, handles.y1,'linewidth',2);

ylabel (handles.Fig,'\tau');
xlabel (handles.Fig,'\sigma');
title(handles.Fig,['\phi= ' num2str(round(Fi,2)) '^{\circ}, Cohesion=' num2str(round(Ci,2)), ', UCS= ' num2str(round(SigmaC,2))],'FontSize',12,'color','b');
legend off;
set(handles.Fig,'XGrid','on','YGrid','on');
hold(handles.Fig,'off');

if B<0
txt2 ={'Mohr-Coulomb Formula:',['\tau = ',num2str(round(tan(Fi*pi/180),2)),' .\sigman ',num2str(round(Ci,2))]};
else
txt2 ={'Mohr-Coulomb Formula:',['\tau = ',num2str(round(tan(Fi*pi/180),2)),' .\sigman + ',num2str(round(Ci,2))]};    
end

set(handles.FormFig,'visible', 'on');
title(handles.FormFig, txt2, 'FontSize', 12);


set(handles.EditFric,'String',num2str(round(Fi,2)));
set(handles.EditFric,'Value',(round(Fi,2)));

guidata(hObject, handles);


% --- Executes on button press in FricDec.
function FricDec_Callback(hObject, eventdata, handles)
% hObject    handle to FricDec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fi=get(handles.EditFric,'Value');
Ci=get(handles.EditCoh,'Value');
Fi=Fi-1;

hold(handles.Fig,'off');
hPlotData1 = plot(handles.Fig,handles.x2,handles.y2);% select plot
delete(hPlotData1);
cla(handles.Fig)
hPlotData2 = plot(handles.FormFig,handles.x2,handles.y2);% select plot
delete(hPlotData2);

if isempty(handles.data)
    answer=modaldlgM('Title','Loading Data');
    switch answer
        case 'Yes'
            %*****************
            [F P]=uigetfile({'*.txt','n*2 Data Matrix in Text';'*.m','Data in mFile';...
                '*.mat','Matlab File'},'Load n*2 data matrix');
            if F
                handles.StrSt=load([P F]);
                handles.MaxSt=handles.StrSt(:,2);
                handles.MinSt=handles.StrSt(:,1);
            else
                warndlg('No Dtat Has been Selected','Plz Enter Data!') ;
            end
            hPlotData = plot(handles.FigReg,handles.x1,handles.y1);% select plot
            delete(hPlotData);
            hPlotData = plot(handles.Fig,handles.x2,handles.y2);% select plot
            delete(hPlotData);
            cla(handles.FigReg);
            cla(handles.Fig);
            set(handles.FormFigReg,'visible', 'off');
            set(handles.FormFig,'visible', 'off');
            
            set(handles.uitable,'Data',handles.StrSt);
            handles.data=get(handles.uitable,'Data');
            %************************
        case 'No'
            
    end
end

if iscell(handles.data); handles.data = cell2mat(handles.data); end


n=length(handles.data);
for i=1:n
    if handles.data(i,1)~=0||handles.data(i,2)~=0
        A(i,1)=handles.data(i,1);
        A(i,2)=handles.data(i,2);
    end
end
%disp(A)
handles.MaxSt=A(:,2);
handles.MinSt=A(:,1);
n=length(handles.MaxSt);
handles.C=[];
handles.R=[];
handles.x2=[];
handles.y2=[];

for i=1:n
    handles.C(i)=(handles.MaxSt(i)+handles.MinSt(i))/2;
    handles.R(i)=(handles.MaxSt(i)-handles.MinSt(i))/2;
end
 XLimit=min(handles.data(:))-0.1*(max(handles.data(:))-min(handles.data(:)));

mdl=fitlm(handles.MinSt,handles.MaxSt);

AB=mdl.Coefficients;
B=table2array(AB(1,1));%Line Intercept
A=table2array(AB(2,1));%Line Slope
R_Sq=mdl.Rsquared.Ordinary;
size(handles.MinSt);

SigmaC=B;
Nphi=A;
Pesi=atan(A)*180/pi;
% Fi=asin((Nphi-1)/(Nphi+1))*180/pi;
% Ci=SigmaC*(1-sin(Fi*pi/180))/(2*cos(Fi*pi/180));
handles.x1=min(handles.MinSt):0.1:mean(handles.MaxSt);
handles.y1=tan(Fi*pi/180).*handles.x1+Ci;

for i=1:n
    handles.x2=handles.MinSt(i):0.1:handles.MaxSt(i);
    handles.y2=sqrt(handles.R(i).^2-(handles.x2-handles.C(i)).^2);
    plot(handles.Fig,handles.x2,handles.y2);
    hold(handles.Fig,'on');
set(handles.Fig,'XLim',[XLimit 1.1*max(handles.data(:))],'YLim',[XLimit 1.1*max(handles.data(:))]);
end

plot(handles.Fig,handles.x1, handles.y1,'linewidth',2);

ylabel (handles.Fig,'\tau');
xlabel (handles.Fig,'\sigma');
title(handles.Fig,['\phi= ' num2str(round(Fi,2)) '^{\circ}, Cohesion=' num2str(round(Ci,2)), ', UCS= ' num2str(round(SigmaC,2))],'FontSize',12,'color','b');
legend off;
set(handles.Fig,'XGrid','on','YGrid','on');
hold(handles.Fig,'off');

if B<0
txt2 ={'Mohr-Coulomb Formula:',['\tau = ',num2str(round(tan(Fi*pi/180),2)),' .\sigman ',num2str(round(Ci,2))]};
else
txt2 ={'Mohr-Coulomb Formula:',['\tau = ',num2str(round(tan(Fi*pi/180),2)),' .\sigman + ',num2str(round(Ci,2))]};    
end

set(handles.FormFig,'visible', 'on');
title(handles.FormFig, txt2, 'FontSize', 12);


set(handles.EditFric,'String',num2str(round(Fi,2)));
set(handles.EditFric,'Value',(round(Fi,2)));

guidata(hObject, handles);


% --- Executes on button press in Help.
function Help_Callback(hObject, eventdata, handles)
% hObject    handle to Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
winopen('Document.pdf')
guidata(hObject, handles);
