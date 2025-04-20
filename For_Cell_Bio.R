
library(qrcode)
library(ggplot2)
url = 'https://docs.google.com/document/d/1IEoPcQnUHGnx3oV6VA-7GahHNxoQphzI-6JQ91ILfZY/edit?tab=t.0'
qr_code_CELLBIO = qrcode::qr_code(url)
plot(qr_code_CELLBIO)

ggsave("qr_code_CELLBIO.png")
