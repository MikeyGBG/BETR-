global obj;
obj = setupSystemObjects();
global tracks;
tracks = initializeTracks(); % Create an empty array of tracks.

% Create System objects used for reading video, detecting moving objects,
% and displaying the results.
nextId = 1; % ID of the next track
while ~isDone(obj.reader)
    % Detect moving objects, and track them across video frames.
    frame = obj.reader.step();
    [centroids, bboxes, mask] = detectObjects(obj,frame);
    predictNewLocationsOfTracks(obj,tracks);
    [assignments, unassignedTracks, unassignedDetections] = ...
        detectionToTrackAssignment(tracks,centroids);
    
    updateAssignedTracks(assignments);
    updateUnassignedTracks(unassignedTracks);
    deleteLostTracks(tracks);
    createNewTracks(unassignedDetections,tracks,centroids,bboxes,nextId);
    displayTrackingResults(obj,frame,tracks,mask,nextId);      
end