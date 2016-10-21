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

% Last Modified by GUIDE v2.5 21-Oct-2016 03:42:39

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
set(gca, 'XTick', [], 'YTick', []) % No muestra las marcas de la se�al de los ejes 




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

%Establece el rect�ngulo m�s peque�o que puede contener toda la regi�n, con
%las propiedades optenida con el metodo anterior

pb = prop.BoundingBox
rectangle('Position',pb,'EdgeColor','g','LineWidth',2);
hold on

%crea los puntos de la imagen binar�a
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

% s = find([propied.area]<500);
% for n=1:size(s,2)
%     d = round(propied(s(n)).BoundingBox);
%     bw(d(2):d(2)+d(4),d(1):d(1)+d(3)) = 0;
% end
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
subplot 121; imshow(bw); title('Original');
subplot 122; imshow(bw2); title('Alineada');
%ahora a sacar ancho y largo
    figure(29); 
    imshow(bw2);
 bw = im2bw(bw2);
prop = regionprops(bw2,'all');
N = length(prop);

%Establece el rect�ngulo m�s peque�o que puede contener toda la regi�n, con
%las propiedades optenida con el metodo anterior

pb = prop.BoundingBox
rectangle('Position',pb,'EdgeColor','g','LineWidth',2);
hold on

%crea los puntos de la imagen binar�a
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

bw = imrotate(bw2,180);

%bw= imrotate(bw,180);

%Hallamos el n�mero de filas y col�mnas de la imagen
[fil,col] = size(bw);

%Creamos un vector cuyo tama�o es el n�mero de col�mnas de la imagen
vec = zeros(1,col);

%Creamos el histograma para la im�gen
for i=1: col
    for j =1: fil
        if (bw(j,i) == 1)
            vec(i) = vec(i)+1;
        end
    end
end
figure(1);
subplot 122; plot(vec);

%Guardamos en sv el tama�o del vector
sv = size(vec)

%%%%%%%%%%%%%%%%%% HALLAMOS LOS PUNTOS INICIALES DEL TALLO %%%%%%%%%%%%%%%%
%Guardamos en x la columna donde inicia el esqueje (inicio del tallo)
x=1;
for i=1:sv(2)
    if(vec(i) == 0)
        x=x+1;
    else
        break;
    end
end


%%%%%%%%%%%%%%%%%%% HALLAMOS LOS PUNTOS INICIALES DE LA HOJA %%%%%%%%%%%%%%
%Guardamos en y la columna donde termina el esqueje
y=x;
for i=x:sv(2)
    if(vec(i) ~= 0)
        y=y+1;
    else
        break;
    end
end

%Hallamos el valor promedio del grosor (en px) del tallo
prom = 0;
for i=x:(x+200)
    prom = prom + vec(i);
end
prom = prom/200;


%Hallamos la columna donde nace la hoja
dis = ((x+400));
co = 0;
t = prom+15;
for i=x:(dis)
    if (vec(i) < (t))
        co = i;
    end
end


%Contamos el n�mero de pixeles blancos en la columna y 
%Lo almacenamos en sumax
sumax = 0;
for i=1: fil
    if (bw(i,co) == 1)
        sumax = sumax+1;
    end
end
sumax = sumax/2;


%Hallamos la fila donde nace la hoja y le sumamos la mitad del valor de
%sumax
fi = 0;
for i=1: fil
    if (bw(i,co) == 1)
        fi = i;
        break;
    end
end
fi = fi+sumax;

%Guardamos en y1 la fila donde inicia el esqueje (inicio del tallo) 
y1 = 0;
for i=1: fil
    if (bw(i,x) == 1)
        y1 = i;
        break;
    end
end
y1 = y1 +sumax;


%%%%%%%%%% TRAZAMOS DOS RECTAS POR LOS PUNTOS ENCONTRADOS %%%%%%%%%%%%%%%%%
subplot 121; imshow(bw); impixelinfo
hold on;
%Trazamos rectas por los puntos 
P1=[co,0]; P2=[co,fil];
recta = plot([P1(1) P2(1)],[P1(2) P2(2)],'r','LineWidth',1);

P3=[0,fi]; P4=[col,fi];
recta1 = plot([P3(1) P4(1)],[P3(2) P4(2)],'r','LineWidth',1);

P5=[x,0];P6=[x,fil];
recta2 = plot([P5(1) P6(1)],[P5(2) P6(2)],'g','LineWidth',1);

P7=[0,y1]; P8=[col,y1];
recta3 = plot([P7(1) P8(1)],[P7(2) P8(2)],'g','LineWidth',1);

h1 = imdistline(gca,[x co],[y1 fi]);
    h2 = getDistance(h1);
    h2 = h2/10;
area = prop.Area;
area = area/10;
esqueLongi = pb(3);
esqueLongi = esqueLongi/10;
maxLargo = str2double(get(handles.maxLargo,'String'));
largoMin = str2double(get(handles.largoMin,'String'));
distancia= str2double(get(handles.primeraHoja,'String'));
tipo = deterTipo(maxLargo,largoMin,distancia,esqueLongi,h2);
set(handles.longiMaxi,'string',esqueLongi);
set(handles.areaEsque,'string',area);
set(handles.distaHoja,'string',h2);
set(handles.tipEsque,'string',tipo);

function maxLargo_Callback(hObject, eventdata, handles)
% hObject    handle to maxLargo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxLargo as text
%        str2double(get(hObject,'String')) returns contents of maxLargo as a double
global maxLargo;
maxLargo = str2double(get(hObject,'String'));
if isnan(maxLargo)
    msgbox('el valor ingresado debe ser num�rico');
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
    msgbox('el valor ingresado debe ser num�rico');
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
    msgbox('el valor ingresado debe ser num�rico');
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
set(gca, 'XTick', [], 'YTick', []) % No muestra las marcas de la se�al de los ejes 
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


% --- Executes on button press in clasifica.
function clasifica_Callback(hObject, eventdata, handles)
% hObject    handle to clasifica (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


