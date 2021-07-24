function varargout = UTS_ILLDA(varargin)
% UTS_ILLDA MATLAB code for UTS_ILLDA.fig
%      UTS_ILLDA, by itself, creates a new UTS_ILLDA or raises the existing
%      singleton*.
%
%      H = UTS_ILLDA returns the handle to a new UTS_ILLDA or the handle to
%      the existing singleton*.
%
%      UTS_ILLDA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UTS_ILLDA.M with the given input arguments.
%
%      UTS_ILLDA('Property','Value',...) creates a new UTS_ILLDA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UTS_ILLDA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UTS_ILLDA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help UTS_ILLDA

% Last Modified by GUIDE v2.5 24-Jul-2021 09:50:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UTS_ILLDA_OpeningFcn, ...
                   'gui_OutputFcn',  @UTS_ILLDA_OutputFcn, ...
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


% --- Executes just before UTS_ILLDA is made visible.
function UTS_ILLDA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UTS_ILLDA (see VARARGIN)

% Choose default command line output for UTS_ILLDA
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes UTS_ILLDA wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = UTS_ILLDA_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    [filename,pathname] = uigetfile({'*.*'});
 
    if ~isequal(filename,0)
        
        Img = imread(fullfile(pathname,filename));
        [~,~,dim] = size(Img);
        if dim == 3
            Img = rgb2gray(Img);
        end
 
        axes(handles.axes1)
        imshow(Img)
        title('Citra Grayscale Asli')
        handles.Img = Img;
        guidata(hObject, handles)
    else
        return
    end
catch
end

% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
    Img = handles.Img;
    [baris,kolom,~] = size(Img);

    histogram_equalization = histeq(Img);
    axes(handles.axes2)
    imshow(histogram_equalization)
    title('Citra Histogram Equalization')
    handles.histogram_equalization = histogram_equalization;
    guidata(hObject, handles)
    
    axes(handles.axes3)
    h = histogram(Img(:));
    h.FaceColor = [0.5 0.5 0.5];
    xlim([0 255])
    grid on
    title('Histogram')
    
    axes(handles.axes4)
    h = histogram(histogram_equalization(:));
    h.FaceColor = [0.5 0.5 0.5];
    xlim([0 255])
    grid on
    title('Histogram')
    
    set(handles.radiobutton1,'Value',1)
    set(handles.radiobutton2,'Value',0)

% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
    Img = handles.Img;
    [baris,kolom,~] = size(Img);

    median_filter = medfilt2(Img,[3 3]);
    axes(handles.axes2)
    imshow(median_filter)
    title('Citra Median Filter')
    handles.median_filter = median_filter;
    guidata(hObject, handles)
    
    axes(handles.axes3)
    h = histogram(Img(:));
    h.FaceColor = [0.5 0.5 0.5];
    xlim([0 255])
    grid on
    title('Histogram')
    
    axes(handles.axes4)
    h = histogram(median_filter(:));
    h.FaceColor = [0.5 0.5 0.5];
    xlim([0 255])
    grid on
    title('Histogram')
    
    set(handles.radiobutton1,'Value',0)
    set(handles.radiobutton2,'Value',1)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname] = uigetfile('*.*');
% untuk untuk menyeleksi file gambar khusus RGB
if ~isequal(filename,0)
Img = imread(fullfile(pathname,filename));
[~,~,m] = size(Img);
if m == 3
axes(handles.axes5)
imshow(Img)
handles.Img = Img;
title('RGB Image')
guidata(hObject, handles)
else
msgbox('Citra masukan harus citra RGB')
end
else
return
end
% untuk mengaktifkan radiobutton
set(handles.radiobutton3,'Enable','on')
set(handles.radiobutton4,'Enable','on')
set(handles.radiobutton5,'Enable','on')
set(handles.radiobutton6,'Enable','on')

% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
set(handles.radiobutton3,'Value',1)
set(handles.radiobutton4,'Value',0)
set(handles.radiobutton5,'Value',0)
set(handles.radiobutton6,'Value',0)
Img = handles.Img;
R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);
% Untuk merubah gambar RGB menjadi layer Red
Red_Channel = cat(3,R,G*0,B*0);
axes(handles.axes5)
cla('reset')
imshow(Red_Channel)
title('Red Channel')
% Menampilkan Histogram layer Red
axes(handles.axes6)
cla('reset')
h = histogram(R(:));
h.FaceColor = [1 0 0];
xlim([0 255])
grid on
title('Histogram')

% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4
set(handles.radiobutton3,'Value',0)
set(handles.radiobutton4,'Value',1)
set(handles.radiobutton5,'Value',0)
set(handles.radiobutton6,'Value',0)
Img = handles.Img;
R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);
% Untuk merubah gambar RGB menjadi layer Green
Green_Channel = cat(3,R*0,G,B*0);
axes(handles.axes5)
cla('reset')
imshow(Green_Channel)
title('Green Channel')
% Menampilkan Histogram layer Green
axes(handles.axes6)
cla('reset')
h = histogram(G(:));
h.FaceColor = [0 1 0];
xlim([0 255])
grid on
title('Histogram')

% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5
set(handles.radiobutton3,'Value',0)
set(handles.radiobutton4,'Value',0)
set(handles.radiobutton5,'Value',1)
set(handles.radiobutton6,'Value',0)
Img = handles.Img;
R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);
% Untuk merubah gambar RGB menjadi layer Green
Blue_Channel = cat(3,R*0,G*0,B);
axes(handles.axes5)
cla('reset')
imshow(Blue_Channel)
title('Blue Channel')
% Menampilkan Histogram layer Blue
axes(handles.axes6)
cla('reset')
h = histogram(B(:));
h.FaceColor = [0 0 1];
xlim([0 255])
grid on
title('Histogram')

% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6
set(handles.radiobutton3,'Value',0)
set(handles.radiobutton4,'Value',0)
set(handles.radiobutton5,'Value',0)
set(handles.radiobutton6,'Value',1)
% Menampilkan gambar RGB yg sudah dipilih
Img = handles.Img;
axes(handles.axes5)
imshow(Img)
title('RGB Image')
R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);
% Menampilkan histogram RGB
axes(handles.axes6)
cla('reset')
h = histogram(R(:));
h.FaceColor = [1 0 0];
xlim([0 255])
grid on
hold on
h = histogram(G(:));
h.FaceColor = [0 1 0];
xlim([0 255])

h = histogram(B(:));
h.FaceColor = [0 0 1];
xlim([0 255])
hold off
title('Histogram')


% --------------------------------------------------------------------
function MenuUtama_Callback(hObject, eventdata, handles)
% hObject    handle to MenuUtama (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel1,'visible','off');
set(handles.uipanel3,'visible','off');
set(handles.uipanel5,'visible','on');

% --------------------------------------------------------------------
function RGBChannel_Callback(hObject, eventdata, handles)
% hObject    handle to RGBChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel1,'visible','off');
set(handles.uipanel3,'visible','on');
set(handles.uipanel5,'visible','off');

% --------------------------------------------------------------------
function Filtering_Callback(hObject, eventdata, handles)
% hObject    handle to Filtering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel1,'visible','on');
set(handles.uipanel3,'visible','off');
set(handles.uipanel5,'visible','off');


% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pilihan = questdlg('Apakah anda ingin menutup program?', ...
 'Menutup Program', ...
 'Ya','Tidak','Tidak');
% Handle response
switch pilihan
    case 'Ya'
        close(UTS_ILLDA);
    case 'Tidak'
        return;
end
