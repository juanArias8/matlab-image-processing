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
esqueje = binarizar(esqueje);
imshow(esqueje);

bw = im2bw(esqueje);
% figure(1); imshow(bw);

[l ne] = bwlabel(bw);
propied = regionprops(l);
hold on
s = find([propied.Area]<500);
for n=1:size(s,2)
    d = round(propied(s(n)).BoundingBox);
    bw(d(2):d(2)+d(4),d(1):d(1)+d(3)) = 0;
end
% figure(2); imshow(bw);
imwrite(bw,'esquejeBw3.bmp');
bw2 = bw;
prop = regionprops(bw2,'Orientation')
x = prop.Orientation
bw3 = imrotate(bw2, -x);
% figure(3);
% subplot 121; imshow(bw2); title('Original');
% subplot 122; imshow(bw3); title('Alineada');


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
