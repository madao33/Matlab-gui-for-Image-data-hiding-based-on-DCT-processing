function varargout = mainGui(varargin)
% MAINGUI MATLAB code for mainGui.fig
%      MAINGUI, by itself, creates a new MAINGUI or raises the existing
%      singleton*.
%
%      H = MAINGUI returns the handle to a new MAINGUI or the handle to
%      the existing singleton*.
%
%      MAINGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINGUI.M with the given input arguments.
%
%      MAINGUI('Property','Value',...) creates a new MAINGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mainGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mainGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mainGui

% Last Modified by GUIDE v2.5 20-Mar-2020 20:23:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mainGui_OpeningFcn, ...
                   'gui_OutputFcn',  @mainGui_OutputFcn, ...
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


% --- Executes just before mainGui is made visible.
function mainGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mainGui (see VARARGIN)

% Choose default command line output for mainGui
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mainGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mainGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in openfig.
function openfig_Callback(hObject, eventdata, handles)
% hObject    handle to openfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.*', '读取图片文件'); %选择图片文件
if isequal(filename,0)   %判断是否选择
   msgbox('没有选择任何图片');
else
   pathfile=fullfile(pathname, filename);  %获得图片路径
   handles.filepath = pathfile;
   guidata(hObject,handles);
   axes(handles.fig1);
   img = imread(pathfile);
   imshow(img);
end

% --- Executes on button press in savefig.
function savefig_Callback(hObject, eventdata, handles)
% hObject    handle to savefig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
res = handles.result;
if isequal(res,0)
    msgbox('没有得到处理后图像!');
else
    [file,path] = uiputfile();
    savepath = fullfile(path, file);
    disp('文件保存路径:');
    disp(savepath);
    imwrite(res,savepath);
end


function dataText_Callback(hObject, eventdata, handles)
% hObject    handle to dataText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dataText as text
%        str2double(get(hObject,'String')) returns contents of dataText as a double


% --- Executes during object creation, after setting all properties.
function dataText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dataText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function editKey_Callback(hObject, eventdata, handles)
% hObject    handle to editKey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editKey as text
%        str2double(get(hObject,'String')) returns contents of editKey as a double


% --- Executes during object creation, after setting all properties.
function editKey_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editKey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in startInsert.
function startInsert_Callback(hObject, eventdata, handles)
% hObject    handle to startInsert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filepath = handles.filepath
str = get(handles.dataText,'String');
alpha = get(handles.alphaV,'String');
%判断参数是否设置完整
if isequal(str,0)
    msgbox('没有选择任何图片');
elseif isequal(alpha,'string')
    msgbox('请设置嵌入参数');
elseif isequal(filepath,0)
    msgbox('没有选择嵌入图像');
elseif str2num(alpha)>=100 && str2num(alpha)<=10
    msgbox('设置合理的参数');
else
    img = imread(filepath);
    [result,key,flag] = insertData(img,str,str2num(alpha));
    if flag==false
        msgbox('传入数据过大，无法完整嵌入!');
    else
        msgbox('嵌入成功');
        axes(handles.fig2);
        imshow(result);
        disp(num2str(key));
        set(handles.editKey,'String',num2str(key));
        handles.result = result;
        guidata(hObject,handles);
        handles.key=key;
        guidata(hObject,handles);
    end
end

% --- Executes on button press in startExtract.
function startExtract_Callback(hObject, eventdata, handles)
% hObject    handle to startExtract (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
result = handles.result;
key = get(handles.editKey,'String');
if isequal(key,0)
    msgbox('请输入密钥');
else
    key = str2num(key);
    [result1,data] = extractData(result,key);
    
    chard = char(bi2de(data));
    [len,~] = size(chard);
    str = reshape(chard,[1,len]);
    disp('提取的数据：');
    disp(str);
    set(handles.dataText,'String',str);  
    axes(handles.fig2);
    imshow(result1);
    handles.result=result1;
    guidata(hObject,handles);
end

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




function alphaV_Callback(hObject, eventdata, handles)
% hObject    handle to alphaV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alphaV as text
%        str2double(get(hObject,'String')) returns contents of alphaV as a double


% --- Executes during object creation, after setting all properties.
function alphaV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alphaV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
