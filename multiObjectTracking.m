function multiObjectTracking()
% Create System objects used for reading video, detecting moving objects,
% and displaying the results.
obj = setupSystemObjects();
tracks = initializeTracks(); % Create an empty array of tracks.

nextId = 1; % ID of the next track
for (i = 1:100)
% Detect moving objects, and track them across video frames.
    frame = readFrame();
    [centroids, bboxes, mask] = detectObjects(frame);
    predictNewLocationsOfTracks();
    [assignments, unassignedTracks, unassignedDetections] = ...
        detectionToTrackAssignment();
    updateAssignedTracks();
    displayTrackingResults();
end