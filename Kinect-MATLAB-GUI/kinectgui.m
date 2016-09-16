function varargout = kinectgui(varargin)
% KINECTGUI MATLAB code for kinectgui.fig
%      KINECTGUI, by itself, creates a new KINECTGUI or raises the existing
%      singleton*.
%
%      H = KINECTGUI returns the handle to a new KINECTGUI or the handle to
%      the existing singleton*.
%
%      KINECTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KINECTGUI.M with the given input arguments.
%
%      KINECTGUI('Property','Value',...) creates a new KINECTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before kinectgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to kinectgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help kinectgui

% Last Modified by GUIDE v2.5 22-Aug-2016 11:44:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @kinectgui_OpeningFcn, ...
                   'gui_OutputFcn',  @kinectgui_OutputFcn, ...
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


% --- Executes just before kinectgui is made visible.
function kinectgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to kinectgui (see VARARGIN)

% Choose default command line output for kinectgui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes kinectgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = kinectgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Detect Kinect button.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    try
        % First we create VIDEOINPUT objets for both streams.
        handles.colorVid = videoinput('kinect',1);
        handles.depthVid = videoinput('kinect',2);

        % Next, we set the triggering mode to 'manual' because automatic triggering
        % causes it to lose sync.
        triggerconfig([handles.colorVid handles.depthVid],'manual');
        
        % Turn on live feed
        preview(handles.colorVid);
        %set(handles.axes1,'Parent',handles.colorVid);
        %showFrameOnAxis
        %handles.axes1 = handles.colorVid;
        
        % Move data to application data and set GUI status string
        guidata(hObject,handles);
        set(handles.text2, 'String', 'Detected - Ready to record');
        
    % Catch the errors
    catch error
        if strcmp(error.identifier,'MATLAB:nomem')
            msgbox('Insufficient memory.','Error','error');
        else
        msgText = getReport(error)
        msgbox('Unable to detect a Kinect. Make sure it is plugged in and powered on.','Error','error');
        end
    end

% --- Executes during object creation, after setting all properties.
function pushbutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    try
        %stop([handles.colorVid handles.depthVid]);
        delete([handles.colorVid handles.depthVid]);
        guidata(hObject,handles);
        set(handles.text2, 'String', 'Undetected');
    catch
        msgbox('Unable to reset.','Error','error');
    end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles.outputfolder = uigetdir;
    guidata(hObject,handles);



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press for Discrete Record Button.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    % Get appropriate variables
    duration = get(handles.edit2,'String');
    durationtype = get(handles.popupmenu1,'Value');
  
    % Make sure the output folder is set
    try
        filepath = handles.outputfolder;   
    catch error
        msgText = getReport(error)
        msgbox('No output file path set.','Error','error');
        return
    end
    
    % If the duration string is all numbers, then it is valid and we can
    % carry out the discrete record function:
    if ~isempty(duration) && all(ismember(duration,'0123456789'));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Ok here is the meat of the discrete record function: %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        if ~strcmp(num2str(durationtype),'1') % durationtype of 1 means that it is on frames setting
            %Since I didn't program the other ones yet it will
            %automatically set to frames
            msgbox('I didnt program this yet. Im just gonna pretend its set to frames.','Error','error');
        end

        % Now we try and set the stream up:
        try
            handles.colorVid.FramesPerTrigger = str2num(duration);
            handles.depthVid.FramesPerTrigger = str2num(duration);
            start([handles.colorVid handles.depthVid]);
            set(handles.text2, 'String', 'Recording...');
            pause(1); % This pause helps with sync
        catch error
            msgText = getReport(error)
            msgbox('No Kinect detected.','Error','error');
            return
        end
        
        % Trigger the devices to begin logging data
        trigger([handles.colorVid handles.depthVid]);
        
        % If the checked the box to be prompted before saving, notify the
        % user:
        if(get(handles.checkbox1,'Value') == get(handles.checkbox1,'Max'))
            set(handles.text2, 'String', 'Saving data...');
            waitfor(msgbox('Recording Complete. Continue to save data.','Done','Warn'));
        end
        
        % Retrieve the acquired data and save it to filepath
        set(handles.text2, 'String', 'Saving data...');
        [colorFrameData,colorTimeData,colorMetaData] = getdata(handles.colorVid);
        [depthFrameData,depthTimeData,depthMetaData] = getdata(handles.depthVid);
        %colorData = getdata(handles.colorVid);
        %depthData = getdata(handles.depthVid);
        timestring = datestr(datetime('now'));
        timestring = strrep(timestring,':','_');
        timestring = strrep(timestring,'-','_');
        
        %outputpathstring1 = strcat(filepath,'\colorData_',timestring,'.mat');
        %outputpathstring2 = strcat(filepath,'\depthData_',timestring,'.mat');
        outputpathstring1 = strcat(filepath,'\colorFrameData_',timestring,'.mat');
        outputpathstring2 = strcat(filepath,'\colorTimeData_',timestring,'.mat');
        outputpathstring3 = strcat(filepath,'\colorMetaData_',timestring,'.mat');
        outputpathstring4 = strcat(filepath,'\depthFrameData_',timestring,'.mat');
        outputpathstring5 = strcat(filepath,'\depthTimeData_',timestring,'.mat');
        outputpathstring6 = strcat(filepath,'\depthMetaData_',timestring,'.mat');
        save(outputpathstring1, 'colorFrameData');
        save(outputpathstring2, 'colorTimeData');
        save(outputpathstring3, 'colorMetaData');
        save(outputpathstring4, 'depthFrameData');
        save(outputpathstring5, 'depthTimeData');
        save(outputpathstring6, 'depthMetaData');

        % Stop the devices
        stop([handles.colorVid handles.depthVid]);
        set(handles.text2, 'String', 'Detected - Ready to record');
        msgbox('Data saved to disk.','Done','Warn');
    else
        % If the duration wasn't in numbers, throw an error:
        msgbox('Invalid duration.','Error','error');
        return
    end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
