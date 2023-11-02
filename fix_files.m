% Specify the folder where the text files are located
folderPath = 'data/';

% List all text files in the folder
fileList = dir(fullfile(folderPath, '*.txt'));

% Iterate through the list of files
for i = 1:length(fileList)
    % Get the current file name
    fileName = fileList(i).name;
    filePath = fullfile(folderPath, fileName);

    % Read the content of the text file into a cell array
    fileContent = fileread(filePath);
    fileLines = strsplit(fileContent, '\n', 'CollapseDelimiters', false);

    % Process each line
    for j = 1:numel(fileLines)
        line = fileLines{j};
        
        % Check if the line has 76 characters
        if numel(line) <= 74
            % Find the last occurrence of "Z" in the line
            lastZIndex = strfind(line, 'Z');
            if ~isempty(lastZIndex)
                % Add ".000000" before the last "Z"
                modifiedLine = [line(1:lastZIndex(end)-1) '.000000' line(lastZIndex(end):end)];
                fileLines{j} = modifiedLine;
            end
        end
    end

    % Join the modified lines into a single string
    modifiedContent = strjoin(fileLines, '\n');

    % Save the modified content back to the file
    fid = fopen(filePath, 'w');
    fprintf(fid, '%s', modifiedContent);
    fclose(fid);
end
