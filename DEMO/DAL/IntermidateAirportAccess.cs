﻿using DTO;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class IntermidateAirportAccess
    {
        string state = string.Empty;
        public IntermidateAirportAccess() { }
        public string insertListItermedateAirport(List<IntermediateAirportDTO> listIntermediateAirportDTO)
        {
            SqlConnection con = SqlConnectionData.Connect();
            
            con.Open();

            using (SqlTransaction transaction = con.BeginTransaction())
            {
                try
                {
                    StringBuilder queryBuilder = new StringBuilder("INSERT INTO INTERMEDIATE_AIRPORT (FlightID, AirportID, LayoverTime, Note) VALUES ");
                    List<SqlParameter> parameters = new List<SqlParameter>();

                    for (int i = 0; i < listIntermediateAirportDTO.Count; i++)
                    {
                        IntermediateAirportDTO intermediateAirport = listIntermediateAirportDTO[i];

                        queryBuilder.Append($"(@FlightID_{i}, @AirportID_{i}, @LayoverTime_{i}, @Note_{i}),");

                        SqlParameter flightIDParam = new SqlParameter($"@FlightID_{i}", System.Data.SqlDbType.VarChar);
                        flightIDParam.Value = intermediateAirport.FlightID;
                        parameters.Add(flightIDParam);

                        SqlParameter airportIDParam = new SqlParameter($"@AirportID_{i}", System.Data.SqlDbType.VarChar);
                        airportIDParam.Value = intermediateAirport.AirportID;
                        parameters.Add(airportIDParam);

                        SqlParameter layoverTimeParam = new SqlParameter($"@LayoverTime_{i}", System.Data.SqlDbType.Time);
                        layoverTimeParam.Value = intermediateAirport.LayoverTime;
                        parameters.Add(layoverTimeParam);

                        SqlParameter noteParam = new SqlParameter($"@Note_{i}", System.Data.SqlDbType.NVarChar);
                        noteParam.Value = string.IsNullOrEmpty(intermediateAirport.Note) ? (object)DBNull.Value : intermediateAirport.Note;
                        parameters.Add(noteParam);
                    }

                    if (queryBuilder.Length > 0 && queryBuilder[queryBuilder.Length - 1] == ',')
                    {
                        queryBuilder.Remove(queryBuilder.Length - 1, 1);
                    }

                    using (SqlCommand cmd = new SqlCommand(queryBuilder.ToString(), con, transaction))
                    {
                        foreach (var param in parameters)
                        {
                            cmd.Parameters.Add(param);
                        }

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected == 0)
                        {
                            transaction.Rollback();
                            return "No rows were inserted.";
                        }
                    }

                    transaction.Commit();
                    return string.Empty; // Chuỗi rỗng xem như thành công
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    return $"Insert failed: {ex.Message}";
                }
                
            }
        }
        public string GetState()
        {
            return this.state;
        }
    }
}