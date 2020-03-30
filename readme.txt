'Code' folder:

'Scanner_Scanner_Verification' is going to crop the original scans and do the verification with reference.
	
'Camera_Scanner_Verification' is going to crop the original camera photos which has to be captured in the 
same camera and chip location, process the cropped images and do the verification with scanner.

'error_analyse_for_point_light_model' is going to calculate the absolute error with different points and camera
location under point light model.

'Template_Generate' is going to generate the template using scanner images.





'Data' folder:

'img_x_set' 'img_y_set' including 4 matrices are the reference's norm maps for chip 1-4. I use set5 as the reference.

'Reference_Set' are reference's intensity pics. Rows are different chips, and columns are different light directions.

'estimated_ideal_template' are templates.

'Camera_Case_balanced' are 3 intensity-balanced cases captured by camera. Rows are different chips, and columns 
are different light directions.

In the 'camera pics', in the pictures taken along the x-direction light and the pictures taken along the y-direction light,
the chip's position is different, so they can not be aligned together and need to be aligned separately.

