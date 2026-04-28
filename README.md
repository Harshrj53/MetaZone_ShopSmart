# MetaZone ShopSmart
Modern E-Commerce Backend API built with Express, Prisma, and MySQL.

## Deployment to AWS EC2

### 1. Launch Instance
- Launch an EC2 instance (Amazon Linux 2023 or 2 recommended).
- In **Security Groups**, allow:
  - Port 22 (SSH)
  - Port 80 (HTTP)
  - Port 5000 (API)

### 2. Setup
- SSH into your instance.
- Clone the repository:
  ```bash
  git clone https://github.com/Harshrj53/MetaZone_ShopSmart.git
  cd MetaZone_ShopSmart
  ```
- Run the setup script:
  ```bash
  chmod +x ec2/setup.sh
  ./ec2/setup.sh
  ```
- Log out and log back in to apply Docker group permissions.

### 3. Configure
- Create a `.env` file:
  ```bash
  cp .env.example .env
  nano .env
  ```
- Fill in your `MONGODB_URI` and other variables.

### 4. Run
- Deploy the application:
  ```bash
  chmod +x ec2/deploy.sh
  ./ec2/deploy.sh
  ```

Your application will be available at `http://<ec2-public-ip>`.
