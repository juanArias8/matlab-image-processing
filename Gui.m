function varargout = Gui(varargin)
% GUI MATLAB code for Gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gui

% Last Modified by GUIDE v2.5 18-Oct-2016 19:18:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gui_OpeningFcn, ...
                   'gui_OutputFcn',  @Gui_OutputFcn, ...
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


% --- Executes just before Gui is made visible.
function Gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Gui (see VARARGIN)

% Choose default command line output for Gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
axes(handles.pantalla); % Establece el eje como actual 
set(gca, 'Box', 'on'); % Se encierran los ejes en una caja 
set(gca, 'XTick', [], 'YTick', []) % No muestra las marcas de la señal de los ejes 




% --- Outputs from this function are returned to the command line.
function varargout = Gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Cargar.
function Cargar_Callback(hObject, eventdata, handles)
% hObject    handle to Cargar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[nombre,direc]=uigetfile('*.*','Abrir Imagen');
if nombre == 0
    return
end

I=imread(fullfile(direc,nombre));
imshow(I);
esqueje=imread(fullfile(direc,nombre));
imshow(esqueje);
set(handles.alinear, 'UserData', esqueje);%guardamos la imagen en el componente
set(handles.alinear,'enable','on');
set(handles.restaurar,'enable','on');


% --- Executes on button press in alinear.
function alinear_Callback(hObject, eventdata, handles)
% hObject    handle to alinear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
esqueje = get(handles.alinear, 'UserData');%obtenemos la imagen guardadas
bw1 = binarizar(esqueje);
    subplot 121; imshow(bw1);
    bw = im2bw(bw1);
    subplot 122;imshow(bw);
    prop= regionprops(bw,'all');

    hold on
    pe = prop.Extrema
    p1 = pe(1,1)
    p5 = pe(5,1)
    if (p1 > 700) && (p5 > 700)
        bw = imrotate(bw,180);
        hold on
        imshow(bw);
    end
   
    imshow(bw);

    bw = bwareaopen(bw,1000);

%extree los datos de la imagen binaria
prop = regionprops(bw,'all');
N = length(prop);

%Establece el rectángulo más pequeño que puede contener toda la región, con
%las propiedades optenida con el metodo anterior

pb = prop.BoundingBox
rectangle('Position',pb,'EdgeColor','g','LineWidth',2);
hold on

%crea los puntos de la imagen binaría
pch = prop.ConvexHull
plot(pch(:,1),pch(:,2),'LineWidth',2);
hold on

%pone puntos extremos
pe = prop.Extrema
plot(pe(:,1),pe(:,2),'m*','LineWidth',1.5);
hold on

%pone el centroide
pc = prop.Centroid
plot(pc(1),pc(2),'*','MarkerSize',10,'LineWidth',2);

hold on

% P1=[pe(8,1) pe(8,2)];P2=[pc(1) pc(2)];
% plot([P1(1) P2(1)],[P1(2) P2(2)],'r','LineWidth',2)
P1=[pe(6,1) pe(6,2)];P2=[pc(1) pc(2)];
plot([P1(1) P2(1)],[P1(2) P2(2)],'r','LineWidth',2)
P1=[pe(4,1) pe(4,2)];P2=[pc(1) pc(2)];
plot([P1(1) P2(1)],[P1(2) P2(2)],'g','LineWidth',2)
P1=[pe(2,1) pe(2,2)];P2=[pc(1) pc(2)];
plot([P1(1) P2(1)],[P1(2) P2(2)],'b','LineWidth',2)
%creando lineas de eje x
[m,n] = size(esqueje);
P1=[0 pc(2)];P2=[m pc(2)];
plot([P1(1) P2(1)],[P1(2) P2(2)],'b','LineWidth',2)
pause(1)
%creando lineas de eje y
P1=[pc(1) 0];P2=[pc(1) n];
plot([P1(1) P2(1)],[P1(2) P2(2)],'b','LineWidth',2)
pause(1)
 
hold on
v1 = [pe(4,1)-pc(1) 0 0]
v2 = [pe(4,1)-pc(1) -(pe(4,2)-pc(2)) 0] 

[a1, a2] = ab2v(v1, v2);

po = prop.Orientation

if v2(2)>0
    bw2 = imrotate(bw, -a2(7));
else
     bw2 = imrotate(bw, a2(7));

end
% figure(2);
% subplot 121; imshow(bw); title('Original');
% subplot 122; imshow(bw2); title('Alineada');

ima1 = imrotate(bw,180);
imwrite(ima1,'ima9.bmp');



function maxLargo_Callback(hObject, eventdata, handles)
% hObject    handle to maxLargo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxLargo as text
%        str2double(get(hObject,'String')) returns contents of maxLargo as a double
global maxLargo;
maxLargo = str2double(get(hObject,'String'));
if isnan(maxLargo)
    msgbox('el valor ingresado debe ser numérico');
end



% --- Executes during object creation, after setting all properties.
function maxLargo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxLargo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function largoMin_Callback(hObject, eventdata, handles)
% hObject    handle to largoMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of largoMin as text
%        str2double(get(hObject,'String')) returns contents of largoMin as a double
global largoMin;
largoMin = str2double(get(hObject,'String'));
if isnan(largoMin)
    msgbox('el valor ingresado debe ser numérico');
end

% --- Executes during object creation, after setting all properties.
function largoMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to largoMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function primeraHoja_Callback(hObject, eventdata, handles)
% hObject    handle to primeraHoja (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of primeraHoja as text
%        str2double(get(hObject,'String')) returns contents of primeraHoja as a double
global distancia;
distancia= str2double(get(hObject,'String'));
if isnan(distancia)
    msgbox('el valor ingresado debe ser numérico');
end

% --- Executes during object creation, after setting all properties.
function primeraHoja_CreateFcn(hObject, eventdata, handles)
% hObject    handle to primeraHoja (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in restaurar.
function restaurar_Callback(hObject, eventdata, handles)
% hObject    handle to restaurar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.maxLargo,'string','');
set(handles.largoMin,'string','');
set(handles.primeraHoja,'string','');
axes(handles.pantalla);
cla reset;
set(gca, 'Box', 'on'); % Se encierran los ejes en una caja 
set(gca, 'XTick', [], 'YTick', []) % No muestra las marcas de la señal de los ejes 
global maxLargo; maxLargo = 0;
global largoMin; largoMin = 0;
global distancia; distancia = 0;
clear all; clc



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
