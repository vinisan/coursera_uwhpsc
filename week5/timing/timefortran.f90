program timefortran 
  implicit none 
  integer, parameter :: ntests = 20
  integer :: n,i,j,k,itest
  real (kind=8), allocatable, dimension(:,:) :: a,b,c
  real (kind=8) :: t1,t2,elapsed_time
  integer (kind=8) :: tclock1, tclock2,clock_rate
  
  call system_clock(tclock1)
  print *, "Will multiply n by n matrices, input n"
  read *, n

  allocate(a(n,n), b(n,n), c(n,n)) 
 
  ! a and b for demo purposes:
  a = 1.d0
  b = 1.d0
  
  call cpu_time(t1)
  do itest=1,ntests
    do j=1,n
      do i=1,n
        c(i,j) = 0.d0
        do k=1,n
          c(i,j) = c(i,j) + a(i,k)*b(k,j)
        enddo
      enddo
    enddo
  enddo
  
  call cpu_time(t2)
  print 10, ntests, t2-t1
10 format("performed ", i4, " matrix multiplication: CPU time = ", f12.8, " seconds")

  call system_clock(tclock2,clock_rate)
  elapsed_time = float(tclock2 - tclock1) / float(clock_rate)
  print 11, elapsed_time
11 format("Elapsed time: ", f12.8, " seconds")
  
end program timefortran 

!gfortran -O3 timefortran.f90 
