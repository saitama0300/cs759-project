input_image='5.jpg'

code_type="opencv"

operation_type="image-smoothening"

filter='gaussian'
kernel_size='3x3'

src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg >> out_opencv.txt

kernel_size='5x5'

src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg >> out_opencv.txt 

filter='median'
kernel_size='3x3'

src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg >> out_opencv.txt

kernel_size='5x5'

src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg >> out_opencv.txt 

filter='normalized'
kernel_size='3x3'

src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg >> out_opencv.txt

kernel_size='5x5'
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg
src/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}-blur/${kernel_size}/${input_image}-out.jpg >> out_opencv.txt

operation_type="edge-detection"
filter='sobel'
kernel_size=''

src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}/${kernel_size}/${input_image}-out.jpg
src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}/${kernel_size}/${input_image}-out.jpg >> out_opencv.txt

operation_type="morphological-operations"
filter='erosin'
kernel_size=''

src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}/${kernel_size}/${input_image}-out.jpg
src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}/${kernel_size}/${input_image}-out.jpg >> out_opencv.txt

filter='dilation'
kernel_size=''

src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}/${kernel_size}/${input_image}-out.jpg
src/${code_type}/${operation_type}/${filter}/${kernel_size}/${filter}.out inputs/${input_image} outputs/${code_type}/${operation_type}/${filter}/${kernel_size}/${input_image}-out.jpg >> out_opencv.txt