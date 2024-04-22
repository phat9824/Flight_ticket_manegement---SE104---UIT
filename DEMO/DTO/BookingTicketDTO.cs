﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class BookingTicketDTO
    {
        private string flightID;
        private string id;
        private string ticketClassID;
        private int ticketStatus;
        private DateTime bookingDate;

        public string FlightID
        {
            get => flightID;
            set => flightID = value;
        }

        public string ID
        {
            get => id;
            set => id = value;
        }

        public string TicketClassID
        {
            get => ticketClassID;
            set => ticketClassID = value;
        }

        public int TicketStatus
        {
            get => ticketStatus;
            set => ticketStatus = value;
        }

        public DateTime BookingDate
        {
            get => bookingDate;
            set => bookingDate = value;
        }
    }
}