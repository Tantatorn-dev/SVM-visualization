function varargout = svm_gui(varargin)
% SVM_GUI MATLAB code for svm_gui.fig
%      SVM_GUI, by itself, creates a new SVM_GUI or raises the existing
%      singleton*.
%
%      H = SVM_GUI returns the handle to a new SVM_GUI or the handle to
%      the existing singleton*.
%
%      SVM_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SVM_GUI.M with the given input arguments.
%
%      SVM_GUI('Property','Value',...) creates a new SVM_GUI or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before svm_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to svm_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help svm_gui

% Last Modified by GUIDE v2.5 13-Dec-2019 08:58:03
global isOpenFromM
if isempty(isOpenFromM) || isOpenFromM == 0
    [ST, I] = dbstack('-completenames', 1);
    if size(ST, 1) > 0
        if strcmp(ST(end).name, 'uiopen')
            opts.WindowStyle = 'replace';
            opts.Interpreter = 'tex';
            errordlg({'\fontsize{10}Do not open fig file directly.', 'Open this GUI by call svm\_gui function in command windows.', 'Or click run in GUIDE.'}, 'Error', opts);
            closereq();
            return
        end
    end
    isOpenFromM = 1;
end
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @svm_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @svm_gui_OutputFcn, ...
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


% --- Executes just before svm_gui is made visible.
function svm_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to svm_gui (see VARARGIN)

% Choose default command line output for svm_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

initialize_gui(hObject, handles, false);

% UIWAIT makes svm_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = svm_gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.

set(handles.selectmethod, 'SelectedObject', handles.Normal);

% Update handles structure
guidata(handles.figure1, handles);




% --- Executes during object creation, after setting all properties.
function datasetTable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to datasetTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'Data', []); % no data at the table at the beginning


% --- Executes during object creation, after setting all properties.
function alphaTable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alphaTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'Data', []);


% --- Executes during object creation, after setting all properties.
function beta0Table_CreateFcn(hObject, eventdata, handles)
% hObject    handle to beta0Table (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'Data', []);


% --- Executes during object creation, after setting all properties.
function kernelTable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kernelTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'Data', []);


% --- Executes during object creation, after setting all properties.
function timeTable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timeTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'Data', cell(0));






% --- Executes on button press in calculateButton.
function calculateButton_Callback(hObject, eventdata, handles)
% hObject    handle to calculateButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global INmatrix INkernel

UIselectMethod = get(handles.selectmethod, 'SelectedObject');
selectMethod = get(UIselectMethod, 'String');

UIselectKernel = get(handles.selectkernel, 'SelectedObject');
selectKernel = get(UIselectKernel, 'String');

data = get(handles.datasetTable, 'data');
if size(data, 1) == 0
    opts.WindowStyle = 'replace';
    opts.Interpreter = 'tex';
    errordlg({'\fontsize{10}Input Data is empty.'}, 'Error', opts);
    return
end

X = data(:, [1 2]);
Y = data(:, 3);

define_parameters;

kernel = Algo_Select(selectMethod, selectKernel);

tic
[alpha, Ker, beta0] = SVM(X, Y, kernel);
t = toc;

set(handles.alphaTable, 'data', alpha);
set(handles.kernelTable, 'data', Ker);
set(handles.beta0Table, 'data', beta0);

timeTable = get(handles.timeTable, 'data');
timeTable(2:end+1, :) = timeTable(1:end, :);
timeTable(1,:) = {selectMethod, selectKernel, t};
set(handles.timeTable,'data',timeTable);

INmatrix = data;
INkernel = selectKernel;


% --- Executes on button press in showGraphButton.
function showGraphButton_Callback(hObject, eventdata, handles)
% hObject    handle to showGraphButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global INmatrix INkernel

alpha = get(handles.alphaTable,'data');
beta0 = get(handles.beta0Table,'data');

UIselectMethod = get(handles.selectmethod, 'SelectedObject');
selectMethod = get(UIselectMethod, 'String');

UIselectKernel = get(handles.selectkernel, 'SelectedObject');
selectKernel = get(UIselectKernel, 'String');

data = get(handles.datasetTable,'data');

if isempty(INmatrix)
    INmatrix = [];
end
if isempty(INkernel)
    INkernel = "";
end
if ~isequal(data, INmatrix) || ~isequal(selectKernel, INkernel)
    opts.WindowStyle = 'replace';
    opts.Interpreter = 'tex';
    errordlg({'\fontsize{10}You change value or parameter.'; 'You much click calculate first.'}, 'Error', opts);
    return
end

X = data(:,[1 2]);
Y = data(:,3);

opts.WindowStyle = 'replace';
opts.Interpreter = 'tex';
dlg = warndlg({'\fontsize{10}Please wait a moment.'; 'It use long time to calculate graph.'}, 'Warning', opts);
dlg.CloseRequestFcn = '';

kernel = Algo_Select(selectMethod, selectKernel);
SVM_plot(X, Y, alpha, beta0, kernel);

if exist('dlg','var') == 1
    delete(dlg);
end


% --- Executes on button press in addDataButton.
function addDataButton_Callback(hObject, eventdata, handles)
% hObject    handle to addDataButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data = get(handles.datasetTable, 'data');
data(end + 1, :) = [0 0 1];
set(handles.datasetTable, 'data', data);


% --- Executes on button press in removeDataButton.
function removeDataButton_Callback(hObject, eventdata, handles)
% hObject    handle to removeDataButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data = get(handles.datasetTable,'data');
if(size(data, 1) == 0)
    disp('Table is empty');
else
    data = data(1 : end - 1, :);
    set(handles.datasetTable, 'data', data);
end


% --- Executes on button press in importButton.
function importButton_Callback(hObject, eventdata, handles)
% hObject    handle to importButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'.csv'}, 'File Selector');
fullpathname = strcat(pathname, filename);
csv_data = csvread(fullpathname);
set(handles.datasetTable, 'data', csv_data);


% --- Executes on button press in clearButton.
function clearButton_Callback(hObject, eventdata, handles)
% hObject    handle to clearButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.datasetTable, 'Data', []);


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.timeTable, 'Data', cell(0));





% --- Executes when selected cell(s) is changed in datasetTable.
function datasetTable_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to datasetTable (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(eventdata.Indices)
    Indices = eventdata.Indices;
    if Indices(2) == 3
        data = get(handles.datasetTable,'data');
        val = data(Indices(1), 3);
        if val == 1
            val = -1;
        else
            val = 1;
        end
        data(Indices(1), 3) = val;
        set(handles.datasetTable, 'data', data);
    end
end


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global isOpenFromM
isOpenFromM = 0;
