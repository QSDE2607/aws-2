<h1> Xây dựng cơ sở dữ liệu cho Google Play Store </h1>

Google Play Store là một chợ ứng dụng của hệ điều hành Android cho phép người dùng tìm kiếm và tải các ứng dụng, trò chơi về thiết bị di động của mình, dưới sự quản lý của Google. Ở bài Assignment này, bạn sẽ được thực hành để xây dựng một cơ sở dữ liệu để lưu trữ các thông tin ứng dụng trên Google Play Store sử dụng Amazon RDS.
<ul>
<li>Tạo được VPC cho hệ thống. </li>
<li>Tạo được Security Group và Subnet Group. </li>
<li>Tạo và thiết lập được RDS phù hợp với yêu cầu hệ thống. </li>
<li>Import được dữ liệu lên RDS. </li>
<li>Tạo được Snapshot cho RDS và có thể khôi phục dữ liệu từ Snapshot đó. </li>
<li>(Nâng cao) So sánh hiệu năng giữa Amazon RDS và On Premise Database. </li>
</ul>

Tài nguyên

Bạn sẽ cần tải Dataset tại [Link sau](https://drive.google.com/drive/folders/1mzGazJVwJRXFJkTtz6p-bA27eWg2ecJO?usp=sharing) để có thể hoàn thành bài tập này. Dataset sẽ gồm 2 file như sau:

app.csv: File csv chứa thông tin về các ứng dụng trên Google Play Store.
review.csv: FIle csv chứa các đánh giá về ứng dụng trên Googgle Play Store.

<h2> Chi tiết dự án:</h2>
1. Tạo VPC cho hệ thống

Để tạo một Amazon RDS Database thì đầu tiên bạn sẽ cần tạo một VPC trước, VPC sẽ bao gồm 2 subnet như sau:

1 Private Subnet
1 Public Subnet được gắn với Internet Gateway
Lưu ý: Hai Subnet này cần được đặt ở hai Availability Zone khác nhau để có thể tạo được RDS.

![image](https://github.com/QSDE2607/aws-2/assets/171625181/8f515566-4534-4190-8422-c5976e122f8a)


2. Tạo được Security Group và Subnet Group

Bạn sẽ cần tạo một Security Group để kiểm soát được các truy cập đến RDS. Security Group này sẽ có 1 Inbound Rule để cho phép truy cập vào RDS thông qua port 3306 như sau:

![image](https://github.com/QSDE2607/aws-2/assets/171625181/6929ce5d-509a-4201-8231-71cb5333fd76)


Bạn cũng sẽ cần tạo một Subnet Group để tập hợp các Subnet của hệ thống.

![image](https://github.com/QSDE2607/aws-2/assets/171625181/29420114-6254-4f48-8efc-cf21e256d54e)



3. Tạo và thiết lập được RDS phù hợp với yêu cầu hệ thống

Tiếp theo, bạn sẽ tạo một RDS Database với các thiết lập như sau:

Phần "Engine options" sẽ chọn MySQL để làm cơ sở dữ liệu, version sẽ là MySQL 8.0.23.

![image](https://github.com/QSDE2607/aws-2/assets/171625181/aaeab4b3-e718-47a3-bc77-565b37bc187b)


Phần "Templates" bạn hãy chọn "Free Tier" để đảm bảo sẽ không bị tính phí khi sử dụng RDS, sau đó các phần "DB instance class", "Storage", "Availability & durability" sẽ giữ nguyên như thiết lập mặc định của RDS.

![image](https://github.com/QSDE2607/aws-2/assets/171625181/d5322b0f-6ce2-47d8-bb58-e6b0672058cb)


Phần "Connectivity", bạn hãy chọn các VPC, Subnet Group và Security Group đã được tạo từ trước.

![image](https://github.com/QSDE2607/aws-2/assets/171625181/8e02849f-2691-410a-88d5-e831e3226a19)


Chú ý: Bạn cần vào phần "Additional configuration" và đặt tên cho Database thông qua trường "Initial database name".

![image](https://github.com/QSDE2607/aws-2/assets/171625181/916a4471-d0e1-4db0-b908-28554c397def)


Cuối cùng, bạn sẽ cần kiểm tra phần "Estimated monthly costs" và đảm bảo rằng tất cả các thiết lập bên trên không bị tính phí khi sử dụng Free Tier, sau đó nhấn "Create Database", sau đó bạn sẽ cần chờ một thời gian để AWS khởi tạo Database của bạn.

![image](https://github.com/QSDE2607/aws-2/assets/171625181/29ba9591-36ad-44b6-9434-476c6ac11fcd)


4. Sử dụng Parameter Groups để thay đổi thiết lập cho RDS

Bạn hãy tạo một Parameter Groups mới và thay đổi thiết lập cho trường max_connections thành 1000 và gắn vào RDS vừa tạo.

![image](https://github.com/QSDE2607/aws-2/assets/171625181/bbdffacd-ef69-404f-bd60-07291d125634)



5. Import được dữ liệu lên RDS

Bạn sẽ cần tải tập dữ liệu từ Google Play Store ở phần "Tài nguyên" và import được các dữ liệu đó vào RDS vừa tạo, đồng thời cũng cần cài đặt DataGrip - một ứng dụng giúp bạn tương tác được với các cơ sở dữ liệu để thực hiện các thao tác import và truy vấn.

Để kết nối đến RDS, bạn sẽ cần các thông tin sau:

URL kết nối đến RDS (có thể tìm thấy ở phần "Endpoint" trong RDS Console).
User, Password mà bạn đã thiết lập khi tạo RDS.
Database Name: Tên Database mà bạn đã khai báo khi tạo RDS.
![image](https://github.com/QSDE2607/aws-2/assets/171625181/61d5b101-8b76-4d10-98f5-9a691e43a04a)


Để Cài đặt, import dữ liệu và thực thi truy vấn, bạn có thể xem ở các link trong phần "Tài nguyên".

6. Tạo được Snapshot cho RDS và có thể khôi phục dữ liệu từ Snapshot đó.

Tiếp theo, bạn sẽ cần tạo một "Manual snapshots" để thực hiện backup cho RDS, và sau đó thực hiện thao tác khôi phục RDS từ Snapshot đó.

![image](https://github.com/QSDE2607/aws-2/assets/171625181/a27bc94b-8ecd-47ff-8b3e-6cb4b489e136)


7.  Giám sát RDS thông qua Cloud Watch:

Bạn cần vào Tab "Monitoring" để xem các thông số hiện tại qua Cloud Watch.


![image](https://github.com/QSDE2607/aws-2/assets/171625181/694cc068-b4c9-4e76-bc3c-ed840350a677)


8. (Nâng cao) So sánh hiệu năng giữa Amazon RDS và On Premise Database

Ở yêu cầu nâng cao, bạn sẽ cần viết các truy vấn để giải quyết một số bài toán. Sau đó bạn cần chạy truy vấn này trên RDS và trên máy Local của bạn và so sánh thời gian thực hiện giữa hai bên.

Yêu cầu 1: Viết truy vấn để tính tổng các trường "Sentiment_Subjectivity" và "Sentiment_Polarity" theo từng loại danh mục của ứng dụng. Kết quả sẽ có dạng như sau:

![image](https://github.com/QSDE2607/aws-2/assets/171625181/7d27c8cc-3794-420e-b7b4-58040b47e3a3)


Yêu cầu 2: VIết truy vấn để đếm số lượng ứng dụng theo từng loại đánh giá "Negative", "Positive", "Neutral"  theo từng loại danh mục của ứng dung. Kết quả sẽ có dạng như sau:

![image](https://github.com/QSDE2607/aws-2/assets/171625181/31073ef9-e8d1-44ee-9b18-25543e34c732)


Yêu cầu 3: Một danh mục được gọi là nổi bật, nếu như tổng số từ của của các review những ứng dụng trong danh mục đó nhiều nhất. Bạn hãy viết truy vấn để tìm danh mục nổi bật đó, đồng thời tính được giá trung bình của mỗi ứng dụng thuộc danh mục đó. Kết quả sẽ như sau:

![image](https://github.com/QSDE2607/aws-2/assets/171625181/6f95c4d6-99a0-439f-959e-736a28cb0d0f)


Kết quả này có nghĩa là danh mục GAME có tổng số từ trong các review là 1023093 và giá trung bình của mỗi ứng dụng thuộc danh mục GAME và $4.66.

Lưu ý: Sau khi được chấm điểm bài Assignemt, bạn hãy xóa RDS Instance vừa tạo cũng như các dịch vụ không cần thiết để tránh bị tính phí sử dụng khi hết Free Tier.
